//
//  ContentView.swift
//  Counter
//
//  Created by Yashwanth V on 10/10/26.
//

import SwiftUI

enum HapticStyle: String, CaseIterable, Identifiable {
    case soft, light, medium, rigid, heavy

    var id: String { rawValue }
    var title: String { rawValue.capitalized }

    var uiStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .soft: .soft
        case .light: .light
        case .medium: .medium
        case .rigid: .rigid
        case .heavy: .heavy

        }
    }
    var detail: String {
        switch self {
        case .soft: "A cushioned, muffled tap."
        case .light: "A small, quick tap."
        case .medium: "A balanced tap."
        case .rigid: "A sharp, crisp click."
        case .heavy: "A strong, weighty thump."
        }
    }
}

struct ContentView: View {
    @State private var showSettings = false
    @State private var rating: Int = 0
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @AppStorage("hapticStyle") private var hapticStyle: HapticStyle = .soft
    private let impactFeedback = UIImpactFeedbackGenerator(style: .rigid)

    var body: some View {

        NavigationStack {

            HStack(spacing: 16) {
                Button {
                    withAnimation { rating -= 1 }
                } label: {
                    Image(systemName: "minus").font(
                        .system(size: 30, weight: .bold)
                    )
                    .frame(width: 55, height: 55)
                }
                .accessibilityLabel("Decrease")
                .disabled(rating == 0)
                .buttonRepeatBehavior(.enabled)

                Text("\(rating)")
                    .font(
                        .system(size: 64, weight: .bold, design: .rounded)
                            .monospacedDigit()
                    )
                    .frame(minWidth: 100)
                    .contentTransition(.numericText(value: Double(rating)))

                Button {
                    withAnimation { rating += 1 }
                } label: {
                    Image(systemName: "plus").font(
                        .system(size: 30, weight: .bold)
                    )
                    .frame(width: 55, height: 55)
                }
                .accessibilityLabel("Increase")
                .disabled(rating == 999)
                .buttonRepeatBehavior(.enabled)
            }
            .buttonStyle(.glass)
            .buttonBorderShape(.circle)
            .font(.title)
            .padding()
            .onChange(of: rating) {
                if hapticsEnabled {
                    UIImpactFeedbackGenerator(style: hapticStyle.uiStyle)
                        .impactOccurred()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Counter").font(.largeTitle).bold(true)
                        .fixedSize(horizontal: true, vertical: false)

                }.sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }

            }

        }
        .sheet(isPresented: $showSettings) {

            NavigationStack {

                Form {
                    Section {
                        Toggle("Haptics", isOn: $hapticsEnabled)
                        Picker("Style", selection: $hapticStyle) {
                            ForEach(HapticStyle.allCases) { style in
                                Text(style.title).tag(style)
                            }
                        }
                        .disabled(!hapticsEnabled)
                    } footer: {
                        if hapticsEnabled {
                            Text(hapticStyle.detail)
                        } else {
                            Text("Haptics are disabled.")
                        }
                    }
                }.navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(role: .close) {
                                showSettings = false
                            }
                        }
                    }
            }.presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])

        }
    }
}
#Preview {
    ContentView()
}

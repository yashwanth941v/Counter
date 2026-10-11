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
    @State private var reset = false
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @AppStorage("hapticStyle") private var hapticStyle: HapticStyle = .soft
    private let impactFeedback = UIImpactFeedbackGenerator(style: .rigid)

    var body: some View {

        NavigationStack {

            

            Text("\(rating)")
                .font(
                    .system(size: 64, weight: .bold, design: .rounded)
                        .monospacedDigit()
                )
                .frame(width: 200, height: 200)
                .contentTransition(.numericText(value: Double(rating)))
                .glassEffect(.regular.interactive())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .safeAreaInset(edge: .bottom){
                    VStack(spacing: 12) {
                        Button {
                            withAnimation { rating += 1 }
                        } label: {
                            Image(systemName: "plus").font(
                                .system(size: 24, weight: .bold)
                                
                            )
                            .frame(maxWidth: .infinity, minHeight: 50)

                        }
                        .accessibilityLabel("Increase")
                        .disabled(rating == 999)
                        .buttonRepeatBehavior(.enabled)
                        Button {
                            withAnimation { rating -= 1 }
                        } label: {
                            Image(systemName: "minus").font(
                                .system(size: 24, weight: .bold)
                                
                            )
                            .frame(maxWidth: .infinity, minHeight: 50)

                        }
                        .accessibilityLabel("Decrease")
                        .disabled(rating == 0)
                        .buttonRepeatBehavior(.enabled)
                        
                    }
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.roundedRectangle(radius: 999))
                    .font(.title)
                    .padding()
                    .onChange(of: rating) {
                        if hapticsEnabled {
                            UIImpactFeedbackGenerator(
                                style: hapticStyle.uiStyle
                            )
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
                                withAnimation { rating = 0 }
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                            }
                            .accessibilityLabel("Reset counter")
                            .disabled(rating == 0)
                        }
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

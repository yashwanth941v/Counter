//
//  ContentView.swift
//  Counter
//
//  Created by Yashwanth V on 10/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var rating: Int = 0
    @State private var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle = .medium
    @State private var hapticsEnabled: Bool = true
    private var impactFeedback: UIImpactFeedbackGenerator? {
        guard hapticsEnabled else { return nil }
        return UIImpactFeedbackGenerator(style: hapticStyle)
    }

    var body: some View {

        NavigationStack {

            HStack(spacing: 16) {
                Button {
                    withAnimation { rating -= 1 }
                    impactFeedback?.impactOccurred()
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
                    impactFeedback?.impactOccurred()
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
            SettingsSheet(hapticStyle: $hapticStyle, hapticsEnabled: $hapticsEnabled)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
        }
    }
}

struct SettingsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle
    @Binding var hapticsEnabled: Bool
    private let styles: [(UIImpactFeedbackGenerator.FeedbackStyle, String, String)] = [
        (.light, "Light", "Subtle tap — gentle feedback"),
        (.medium, "Medium", "Noticeable bump — standard feedback"),
        (.heavy, "Heavy", "Strong thud — prominent feedback"),
        (.rigid, "Rigid", "Sharp click — precise feedback"),
        (.soft, "Soft", "Muted pop — delicate feedback")
    ]

    private var currentDescription: String {
        if hapticsEnabled {
            return styles.first { $0.0 == hapticStyle }?.2 ?? ""
        }
        return "No haptic feedback"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Enable Haptics", isOn: $hapticsEnabled)
                    Picker("Haptic Style", selection: $hapticStyle) {
                        ForEach(styles, id: \.0) { style, name, description in
                            VStack(alignment: .leading, spacing: 2) {
                                Text(name)
                                Text(description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .tag(style)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.secondary)
                    .disabled(!hapticsEnabled)
                } footer: {
                    Text(currentDescription)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

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
    private let impactFeedback = UIImpactFeedbackGenerator(style: .rigid)

    var body: some View {

        NavigationStack {

            HStack(spacing: 16) {
                Button {
                    withAnimation { rating -= 1 }
                    impactFeedback.impactOccurred()
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
                    impactFeedback.impactOccurred()
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

    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Counter
//
//  Created by Yashwanth V on 10/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var rating: Int = 0

    var body: some View {
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
    }
}

#Preview {
    ContentView()
}

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
                Image(systemName: "minus")
                    .frame(width: 40, height: 40)
            }
            .accessibilityLabel("Decrease")
            .disabled(rating == 0)
            .buttonRepeatBehavior(.enabled)

            Text("\(rating)")
                .font(.system(.title, design: .monospaced))
                .frame(minWidth: 60)
                .contentTransition(.numericText(value: Double(rating)))

            Button {
                withAnimation { rating += 1 }
            } label: {
                Image(systemName: "plus")
                    .frame(width: 40, height: 40)
                    
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

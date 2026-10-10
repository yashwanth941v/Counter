//
//  ContentView.swift
//  Counter
//
//  Created by Yashwanth V on 10/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var rating: Int = 0
    @FocusState private var isFocused: Bool
 
    var body: some View {
        HStack(spacing: 16) {
            Button("Decrease", systemImage: "minus.circle") {
                withAnimation{ rating -= 1}
            }
            .disabled(rating == 0)
            .buttonRepeatBehavior(.enabled)

            
            ZStack {
                Text("\(rating)")
                    .contentTransition(.numericText(value: Double(rating)))
                    .opacity(isFocused ? 0 : 1)

                TextField("0", value: $rating, format: .number)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .opacity(isFocused ? 1 : 0)
                    .onChange(of: rating) { _, newValue in
                        rating = min(max(newValue, 0), 999)
                    }
            }
            .multilineTextAlignment(.center)
            .font(.system(.title, design: .monospaced))
            .frame(width: 80)
            .contentShape(Rectangle())
            .onTapGesture { isFocused = true }
            
            Button("Increase", systemImage: "plus.circle") {
               withAnimation{
                   rating += 1

                }
            }
            .disabled(rating == 999)
            .buttonRepeatBehavior(.enabled)

        }
        .labelStyle(.iconOnly)
        .font(.title)
        .padding()
    }
}

#Preview {
    ContentView()
}

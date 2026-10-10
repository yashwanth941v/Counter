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
            Button("Decrease", systemImage: "minus.circle") {
                rating -= 1
            }
            .disabled(rating == 0)
            
            Text("\(rating)")
                .font(.system(.title, design: .monospaced))                
                .frame(minWidth: 35)
                .contentTransition(.numericText(value: rating))
            
            Button("Increase", systemImage: "plus.circle") {
                rating += 1
            }
            .disabled(rating == 999)
        }
        .labelStyle(.iconOnly)
        .font(.title)
        .padding()
    }
}

#Preview {
    ContentView()
}

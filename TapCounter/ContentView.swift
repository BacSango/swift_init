//
//  ContentView.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 18/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var count:Int = 0
    var body: some View {
        VStack {
            Text("Tap Counter")
                .font(.largeTitle)
            
            ForEach(1...3, id: \.self) { _ in
                CounterView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        
    }
}

#Preview {
    ContentView()
}

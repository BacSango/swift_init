//
//  CounterView.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 18/3/25.
//
import SwiftUI

struct CounterView: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
                .padding(20)
                .background(Color.blue.opacity(0.2))
                .font(.system(size: 30, weight: .bold))
                .cornerRadius(15)
            Button("Increment", systemImage: "plus.circle.fill"){
                count += 1
            }
            .buttonStyle(.borderedProminent)
            Button("Reset"){
                count = 0
            }
            .buttonStyle(.bordered)
        }
    }
}


#Preview {
    CounterView()
}

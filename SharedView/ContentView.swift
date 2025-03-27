//
//  ContentView.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI


class CounterModel: ObservableObject {
    @Published var count: Int = 0
}

struct ContentView: View {
    @State private var count = 0
    @StateObject private var counter = CounterModel()
    
    var body: some View {
        VStack {
            Text("== Parent to child ==")
            
            HStack {
                // c1: use @State
                VStack {
                    Text("View 0: ")
                    ViewChild(count: count)
                }
                
                
                // c2: @Binding
                VStack {
                    Text("View 1: ")
                    ViewChild1(count: $count)
                }
                
                
                // c3: use @ObservedObject
                VStack {
                    Text("View 2: ")
                    ViewChild2(counter: counter)
                }
                
                // c4: use EnvironmentObject
                VStack {
                    Text("View 3: ")
                    ViewChild3()
                        .environmentObject(counter)
                }
                
            }
            
            
            Button("Increase"){
                count += 1
                counter.count += 1
            }
            .buttonStyle(.borderedProminent)
            Divider()
            
            // pass data from child to parent
            Text("== Child to parent ==")
            // c1: Binding
            Text("View 4: ")
            ViewChild4(count: $count)
            
            // c2: Closures
            Text("View 5: ")
            ViewChild5(onButtonPress: handleButtonPress)
            
            // c3: ObservedObject
            Text("View 6: ")
            ViewChild6(counter: counter)
            
            // c4: EnvinronmentObject
            Text("View 7: ")
            ViewChild7()
                .environmentObject(counter)
        }
        .padding()
    }
    
    private func handleButtonPress() {
        count -= 1
    }
}

#Preview {
    ContentView()
}

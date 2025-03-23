//
//  ViewChild6.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild6: View {
    @ObservedObject var counter: CounterModel
    
    var body: some View {
        Button("Reduce from child 3"){
            counter.count -= 1
            
        }
        .buttonStyle(.borderedProminent)
    }
}

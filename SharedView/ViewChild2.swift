//
//  ViewChild2.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild2: View {
    @ObservedObject var counter: CounterModel
    
    var body: some View {
        Text("\(counter.count)")
            .padding(20)
            .background(Color.blue.opacity(0.2))
            .font(.system(size: 30, weight: .bold))
            .cornerRadius(15)
    }
}

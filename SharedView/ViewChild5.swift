//
//  ViewChild5.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild5: View {
    let onButtonPress: (Int) -> Void
    @Binding var count: Int
    var body: some View {
        Button("Reduce from child 2"){
            count -= 1
            onButtonPress(count)
        }
        .buttonStyle(.borderedProminent)
    }
}

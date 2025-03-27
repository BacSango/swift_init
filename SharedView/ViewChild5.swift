//
//  ViewChild5.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild5: View {
    let onButtonPress: () -> Void
    
    var body: some View {
        Button("Reduce from child 2"){
            onButtonPress()
        }
        .buttonStyle(.borderedProminent)
    }
}

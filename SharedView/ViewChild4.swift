//
//  ViewChild4.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild4: View {
    @Binding var count: Int
    var body: some View {
        VStack {
            Button("Reduce from child"){
                count -= 1
            }
                .buttonStyle(.borderedProminent)
        }
    }
}

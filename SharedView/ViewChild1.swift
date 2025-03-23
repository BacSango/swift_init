//
//  ViewChild1.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild1: View {
    @Binding var count: Int
    var body: some View {
        VStack {
            Text("\(count)")
                .padding(20)
                .background(Color.blue.opacity(0.2))
                .font(.system(size: 30, weight: .bold))
                .cornerRadius(15)
        }
    }
}

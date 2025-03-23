//
//  ViewChild3.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild3: View {
    @EnvironmentObject var sharedData: CounterModel
    
    var body: some View {
        Text("\(sharedData.count)")
            .padding(20)
            .background(Color.blue.opacity(0.2))
            .font(.system(size: 30, weight: .bold))
            .cornerRadius(15)
    }
}

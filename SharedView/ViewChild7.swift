//
//  ViewChild7.swift
//  SharedView
//
//  Created by Nguyen Van Bac on 19/3/25.
//

import SwiftUI

struct ViewChild7: View {
    @EnvironmentObject var appData: CounterModel
    
    var body: some View {
        Button("Reduce from child 4"){
            appData.count -= 1
        }
        .buttonStyle(.borderedProminent)
    }
}

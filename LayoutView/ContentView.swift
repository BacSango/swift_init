//
//  ContentView.swift
//  LayoutView
//
//  Created by Nguyen Van Bac on 21/3/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.themeBlue)
                Circle().foregroundStyle(Color.red)
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.themeBlue)
                HStack {
                    Circle()
                        .foregroundColor(.themePink)
                    Circle()
                        .foregroundColor(Color.orange)
                }
                
            }
        }
    }
}



#Preview {
    ContentView()
}

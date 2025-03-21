//
//  SizingView.swift
//  LayoutView
//
//  Created by Nguyen Van Bac on 21/3/25.
//

import SwiftUI

struct SizingView: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.brown)
                    .frame(maxWidth: 200, maxHeight: 200)
                VStack {
                    Text("Rose are read,")
                    Image("Rose")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50)
                        .foregroundColor(.themeRed)
                    Text("Violets are blue.")
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.brown)
                    .frame(maxWidth: 200, maxHeight: 200)
                VStack {
                    Text("I just love")
                    Image("Rose")
                        .resizable()
                        .foregroundStyle(.white)
                        .scaledToFit()
                        .frame(maxWidth: 50)
                    Text("coding with you")
                }
            }
        }
        .font(.headline)
        .foregroundStyle(Color.white)
    }
}

#Preview {
    SizingView()
}

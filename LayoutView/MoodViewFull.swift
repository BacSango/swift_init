//
//  MoodViewFull.swift
//  LayoutView
//
//  Created by Nguyen Van Bac on 21/3/25.
//

import SwiftUI

struct MoodViewFull: View {
    private let emojis = ["😢", "😴", "😁", "😡", "😐"]
    @State var value: String
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.themeMood)
                    .frame(maxWidth: 300, maxHeight: 100)
                VStack {
                    Text("What's your moood?")
                    HStack {
                        ForEach(emojis, id: \.self) { emoji in
                            Button {
                                value = emoji
                            } label: {
                                VStack {
                                    Text(emoji)
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Image(systemName: value == emoji ? "circle.fill" : "circle" )
                                        .font(.system(size: 16))
                                        .foregroundColor(value == emoji ? .blue : .gray)
                                }
                            }
                        }
                    }
                    
                }
                
            }
            
            
        }
    }
}

#Preview {
    var mood = "😐"
    MoodViewFull(value: mood)
}

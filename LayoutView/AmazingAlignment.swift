//
//  AmazingAlignment.swift
//  LayoutView
//
//  Created by Nguyen Van Bac on 21/3/25.
//

import SwiftUI

struct AmazingAlignment: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 50))
                
            Rectangle()
                .frame(width: .infinity, height: 20)
            VStack(alignment: .trailing) {
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 50))
                Rectangle()
                    .frame(width: .infinity, height: 20)
            }
            
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 50))
                .frame(maxWidth: .infinity, alignment: .trailing)
            Rectangle()
                .frame(width: .infinity, height: 20)
            
            HStack(spacing: 20) {
                Spacer()
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 50))
                    .background(Color.yellow)
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 50))
            }
            .background(Color.blue)
            Rectangle()
                .frame(width: .infinity, height: 20)
        }
        .padding(.horizontal)
        .frame(width: 250)
        .border(Color.gray)
    }
}

#Preview {
    AmazingAlignment()
}

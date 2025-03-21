//
//  SpinningView.swift
//  LayoutView
//
//  Created by Nguyen Van Bac on 21/3/25.
//

import SwiftUI

struct SpinningView: View {
    @State private var isDialogPresented = false
    @State private var isSecondDialogPresented = false
    var body: some View {
        ZStack {
            VStack {
                Button("Open Dialog") {
                    isDialogPresented.toggle()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            
            if isDialogPresented {
                Color.black.opacity(0.3) // Background overlay
                    .ignoresSafeArea()
                    .onTapGesture {
                        isDialogPresented = false
                        isSecondDialogPresented = false
                    }

                VStack {
                    Spacer().frame(height: 225) // 5cm space from top

                    VStack {
                        Text("This is a Full-Screen Dialog")
                            .font(.headline)
                            .padding()

                        Button("Close") {
                            isDialogPresented = false
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Open dialog two") {
                            isSecondDialogPresented = true
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight]))
                }
                .offset(y: 0) // Make sure it stays full screen except for the top gap
                .ignoresSafeArea(edges: .bottom) // Prevents clipping at the bottom
                
                // Second Dialog
                if isSecondDialogPresented {
                    Color.black.opacity(0.3) // Dark overlay for second dialog
                        .ignoresSafeArea()
                        .onTapGesture {
                            isSecondDialogPresented = false
                        }

                    VStack {
                        Spacer().frame(height: 125) // Lower position for second dialog

                        VStack {
                            Text("This is Dialog Two")
                                .font(.headline)
                                .padding()

                            Button("Close Dialog Two") {
                                isSecondDialogPresented = false
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight]))
                    }
                    .offset(y: 0)
                    .ignoresSafeArea(edges: .bottom)
                }
                
                
            }
        }
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    SpinningView()
}

//
//  AboutView.swift
//  assign3
//
//  Created by Akash Shetty on 4/14/21.
//

import Foundation

import SwiftUI


struct AboutView: View {
    
    @State var animationVals:CGFloat = 1
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
        
        
        if (verticalSizeClass == .regular) {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                .overlay(
            VStack {
                Button("In this game you have to add addable elements to get the highest score. press me :)") {
                    self.animationVals += 1
                    
                    if (self.animationVals > 2) {
                        self.animationVals = 1
                    }
                }
                .padding(80)
                .background(Color.blue)
                .foregroundColor(Color.black)
                .clipShape(Circle())
                .scaleEffect(animationVals)
                .multilineTextAlignment(.center)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                )
            }
                )
        } else {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.horizontal)
                .overlay(
            HStack {
                Button("press me :)") {
                    self.animationVals += 1
                    
                    if (animationVals > 2) {
                        animationVals = 1
                    }
                }
                .padding(80)
                .background(Color.blue)
                .foregroundColor(Color.black)
                .clipShape(Circle())
                .multilineTextAlignment(.center)
                .scaleEffect(animationVals)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                )
            }
                )
        }
        
    
    }
}

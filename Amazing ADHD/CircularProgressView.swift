//
//  CircularProgressView.swift
//  Amazing ADHD
//
//  Created by MM on 03.11.2022.
//

import SwiftUI

struct CircularProgressView: View {
    
    var progress: CGFloat
//    var strokeColor = Color.blue
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.2)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),Color(#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)), Color(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))]), center: .center),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
//                .foregroundColor(strokeColor)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1), value: progress)
        }
        .frame(width: 220, height: 220)
    }
    
}

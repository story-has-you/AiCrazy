//
//  AnimatedCardFlipView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/4.
// 实践：翻牌特效

import SwiftUI

struct AnimatedCardFlipView: View {
    
    @State private var front = false
    
    var body: some View {
        VStack {
            Image(systemName: "suit.club.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .frame(width: 200, height: 100)
                .foregroundColor(front ? .white : .black)
                .background(front ? .black : .white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .scaleEffect(front ? 1.2 : 0.8)
                .rotation3DEffect(Angle(degrees: front ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(response: 1.5), value: front)
                .onTapGesture {
                    front.toggle()
                }
        }
    }
}

struct AnimatedCardFlipView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCardFlipView()
    }
}

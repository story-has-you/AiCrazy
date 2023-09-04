//
//  ProgressView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/4.
// 实践：载入进度条

import SwiftUI

struct AnimationProgressView: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isOK = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    // 边框粗细
                    .stroke(lineWidth: 6)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(.systemGray6))
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.orange)
                    .cornerRadius(2)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .frame(width: 90, height: 90)
                    .foregroundColor(.orange)
                    .rotationEffect(.degrees(-90))

            }
            .padding()
            
            Button {
                withAnimation(.easeInOut.speed(0.25)) {
                    progress = 1
                }
            } label: {
                Text("开始载入")
            }
        }
    }
}

struct AnimationProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationProgressView()
    }
}

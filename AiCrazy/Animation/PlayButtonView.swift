//
//  PlayButtonView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/4.
// 实践：播放暂停按钮

import SwiftUI

struct PlayButtonView: View {
    
    @State private var isPlaying = false
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                isPlaying.toggle()
            }
            
        } label: {
            if isPlaying {
                Image(systemName: "pause.fill")
                    .transition(.scale)
                    .transition(.opacity)
            } else {
                Image(systemName: "play.fill")
                    .transition(.scale)
                    .transition(.opacity)
            }
        }

       
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}

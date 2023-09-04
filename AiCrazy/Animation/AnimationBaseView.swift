//
//  AnimationBaseView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/4.
//

import SwiftUI

struct AnimationBaseView: View {
    
    @State private var selectedTabIndex = 2
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Who()
                .tabItem {
                    Label("谁在动", systemImage: "person.fill.questionmark")
                }
                .tag(1)
            How()
                .tabItem {
                    Label("怎么动", systemImage: "person.fill")
                }
                .tag(2)
            
            
        }
    }
}

/**
 滑动过渡 .slide: 比如视图从屏幕一边滑入，另一边滑出。写法为 .transition(.slide)
 滑动过渡 .move: 与上述 .slide 几乎一致，但可以自定义滑动的方向。写法为 .transition(edge: .bottom)
 透明度过渡 .opacity: 比如视图从高透明度过渡到完全不透明。写法为 .transition(.opacity)
 缩放过渡 .scale: 比如视图逐渐放大而出现。写法为 .transition(.scale)
 位移过渡 .offset: 比如视图从一个位置过渡到另一个位置。写法为 .transition(.offset(x: 100, y: 0))
 */
struct How: View {
    
    @State private var playTransition = true
    
    var body: some View {
        VStack {
            if playTransition {
                Image("Dandelion")
                    .resizable()
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Button {
                withAnimation {
                    playTransition.toggle()
                }
            } label: {
                Text("播放动画")
            }

        }
    }
}

/**
 谁在动
 */
struct Who: View {
    
    @State private var showAnimation = false
    @State private var offsetX: CGFloat = 150
    let duration = 2.0
    
    var body: some View {
        VStack {
            Button {
                self.showAnimation.toggle()
                self.offsetX = -150
            } label: {
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .rotationEffect(.degrees(showAnimation ? 90 : 0))
                    .scaleEffect(showAnimation ? 0.4 : 5)
                    .padding()
                    .animation(.easeOut(duration: duration), value: offsetX)
            }
            .padding()
            
            Button {
                withAnimation(.easeOut(duration: duration)) {
                    self.showAnimation.toggle()
                    self.offsetX = -150
                }
            } label: {
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .rotationEffect(.degrees(showAnimation ? 90 : 0))
                    .scaleEffect(showAnimation ? 0.4 : 5)
                    .padding()
            }
            .padding()
        }
    }
}



struct AnimationBaseView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBaseView()
    }
}

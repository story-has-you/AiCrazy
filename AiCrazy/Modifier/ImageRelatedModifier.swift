//
//  ImageRelatedModifier.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/3.
//

import SwiftUI

struct ImageRelatedModifier: View {
    var body: some View {
        VStack(spacing: 50) {
            // 自定义修改器
            HStack {
                Image("22")
                    .imageAvatarStyle()
                Image("21")
                    .imageAvatarStyle()
            }
            
            HStack(spacing: 30) {
                VStack {
                    Image("22")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .whiteCardSytle()
                    Label("音乐理论", systemImage: "music.quarternote.3")
                        .frame(width: 150, height: 50)
                        .whiteCardSytle()
                }
                
                // 覆盖
                Image("0")
                    .resizable()
                    .scaleEffect(0.7)
                    .aspectRatio(contentMode: .fill) // 长宽比
                    .frame(width: 150, height: 260)
                    .overlay(alignment: .bottom) {
                        HStack {
                            Spacer()
                            Text("生日快乐")
                                .font(.headline)
                            Spacer()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(.black.opacity(0.7))
                        
                    }
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
                    
            }

            // 前景色
            HStack {
                Text("绘笔")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.orange)
                
                Image(systemName: "scribble.variable")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.orange)
                
                // 背景
                HStack {
                    Text("示例")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(.orange)
                    
                    Text("示例")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            Image("21")
                                .resizable()
                        )
                }
            }
        }
    }
}

struct AvatarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .scaleEffect(2.5)
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}

// 特殊步骤：图片视图修改器
extension Image {
    func imageAvatarStyle() -> some View {
        self
            .resizable()
            .avatarSytle()
    }
}

struct WhiteCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 3)
    }
}

extension View {
    func avatarSytle() -> some View {
        self.modifier(AvatarModifier())
    }
}

extension View {
    func whiteCardSytle() -> some View {
        self.modifier(WhiteCardModifier())
    }
}

struct ImageRelatedModifier_Previews: PreviewProvider {
    static var previews: some View {
        ImageRelatedModifier()
    }
}

//
//  LayoutRelatedView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/8/30.
//

import SwiftUI

struct LayoutRelatedView: View {
    var body: some View {
        VStack {
            // 垂直排列
            VStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                RoundedRectangle(cornerRadius: 25, style: .continuous)
            }
            .foregroundColor(.orange)
            .frame(width: 100, height: 200)
            .padding()
            .background(.white)
            .cornerRadius(25)
            .shadow(radius: 10)
            
            Text("VStack")
                .font(.headline)
            
            Divider().padding()
        
            // 水平排列
            HStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                RoundedRectangle(cornerRadius: 25, style: .continuous)
            }
            .foregroundColor(.blue)
            .frame(width: 200, height: 100)
            .padding()
            .background(.white)
            .cornerRadius(25)
            .shadow(radius: 10)
            
            Text("HStack")
                .font(.headline)
            
            Divider().padding()
            
            // 重叠排列
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .offset(CGPoint(x: -5, y: -3))
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .offset(CGPoint(x: 5, y: 16))
                }
                .opacity(0.7)
                .foregroundColor(.red)
                .frame(width: 200, height: 100)
                .padding()
                .padding(.bottom)
                .background(.white)
                .cornerRadius(25)
                .shadow(radius: 10)
                
                Text("ZStack")
                    .font(.headline)
            }
        }
    }
}

struct LayoutRelatedView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutRelatedView()
    }
}

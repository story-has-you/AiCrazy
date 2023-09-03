//
//  EffectRelatedModifier.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/3.
//

import SwiftUI

struct EffectRelatedModifier: View {
    
    var colors = Gradient(colors: [.white, .blue])

    
    var body: some View {
        VStack {
            // 渐变色
            HStack {
                // 线性渐变: 其中 gradient 参数为颜色参数，startPoint 和 endPoint 分别对应线性渐变的起始和结束位置。
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                // 圆形渐变: 其中 gradient 参数为颜色参数，center 参数为圆形渐变的圆心位置，startRadius 和 endRadius 分别对应鉴别色起始和结束的圆半径位置。
                RoundedRectangle(cornerRadius: 20)
                    .fill(RadialGradient(gradient: colors, center: .center, startRadius: 1, endRadius: 100))
                // 弧度渐变: 其中 gradient 参数为颜色参数，center 参数为圆形渐变的圆心位置。
                RoundedRectangle(cornerRadius: 20)
                    .fill(AngularGradient(gradient: colors, center: .center))
            }
            .frame(height: 150)
            
            // 基础色
            HStack {
                Color.red
                Color.orange
                Color.yellow
                Color.green
                Color.blue
                Color.purple
                Color.primary
                Color.secondary
                Color(red: 100, green: 100, blue: 0)
                Color(hex: "4287F5")
                
            }
            .frame(height: 50)
            
            // 边框
            HStack {
                // 修改器指的是为视图本身矩形框添加边框，因此所得为矩形
                Circle()
                    .border(.green, width: 3)
                // 指的才是为视图中所显示内容添加边框，因此所得为圆形。
                Circle()
                    .strokeBorder(.green, lineWidth: 3)
            }
            .foregroundColor(.white)
            .padding()
            
            // 旋转及缩放
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    // 模拟出在三维空间中形变。3D 旋转的写法中，axis 表示被旋转的轴线参数，参数值 1 代表围绕该轴旋转，x 代表以横轴，y 代表纵轴，z 代表垂直于屏幕平面的轴线
                    .rotation3DEffect(.degrees(30), axis: (x: 0, y: 1, z: 0))
                    .offset(x: 15)
                
                RoundedRectangle(cornerRadius: 10)
                    .scaleEffect(0.6)
            }
            .foregroundColor(.yellow)
            .padding()
            
            
            // 阴影及圆角
            HStack {
                Rectangle()
                    .cornerRadius(10)
                
                Circle()
                    .shadow(radius: 10, x: 10, y: 20)
            }
            .foregroundColor(.blue)
            .padding()
            
            // 半透明与虚化
            HStack {
                Circle()
                    .opacity(0.1)
                Circle()
                    .blur(radius: 3.0)
            }
            .foregroundColor(.red)
            .padding()
            
            // 材质
            ZStack {
                Rectangle()
                    .fill(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                                          center: .center, startAngle: .zero, endAngle: .degrees(360)))
                Text("毛玻璃背景")
                    .font(.title)
                    .bold()
                    .padding(.all, 30)
                    .glassEffect()
                    .cornerRadius(10)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// 扩展颜色至 HEX
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// 毛玻璃特效写法
struct GlassEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

extension View {
    func glassEffect() -> some View {
        self.background(GlassEffect())
    }
}

struct EffectRelatedModifier_Previews: PreviewProvider {
    static var previews: some View {
        EffectRelatedModifier()
    }
}

//
//  GestureRelatedModifier.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/4.
//

import SwiftUI

struct GestureRelatedModifier: View {
    
    @State private var selectedTabIndex = 4
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            LongPressedView()
                .tabItem {
                    Label("长按", systemImage: "hand.tap.fill")
                }
                .tag(0)
            
            TapGestureView()
                .tabItem {
                    Label("轻点", systemImage: "hand.point.up.left.fill")
                }
                .tag(1)
            MagnificationGestureView()
                .tabItem {
                    Label("缩放", systemImage: "magnifyingglass.circle")
                }
                .tag(2)
            RotationGestureView()
                .tabItem {
                    Label("旋转", systemImage: "crop.rotate")
                }
                .tag(3)
            DragGestureView()
                .tabItem {
                    Label("拖拽", systemImage: "hand.draw.fill")
                }
                .tag(4)
        }
        
    }
}

/**
 拖拽手势指的是从一个点出发，向上下左右任意方向滑动一小段距离。其写法和本小节的其他几个类似，下图中有详例，不再赘述。下图的代码中 .onChanged 与上文提到的用途相同，负责处理拖拽过程中的数据变化，而 .onEnded 作为新的修改器，负责处理拖拽结束后的数据变化。
 
 ​本例实际运行效果如下图所示。其中用户拖拽时颜色会变为橘色，对应代码中的 ​.onChanged {_ in isDragging  = true }​；拖拽结束后变回蓝色，对应代码中的 ​.onEnded {_ in isDragging  = false }​。
 */
struct DragGestureView: View {
    
    @State var isGragging = false

    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in
                isGragging = true
            }
            .onEnded { _ in
                isGragging = false
            }
    }
    
    var body: some View {
        Circle()
            .fill(isGragging ? .orange : .blue)
            .frame(width: 200, height: 200)
            .gesture(drag)
    }
}

/**
 旋转手势与缩放手势的写法大体一致，先创建手势参数 rotation 后，使用修改器 ​.gesture(rotation)​ 添加至视图即可。下图代码中值得关注的手势修改器为 ​.onChanged {}​，其用途与上图中的 .updating 类似，也是更新数值。不过本例中我们不希望数值自动还原至初始值，因此就没有使用 @GestureState 和 .updating() 的组合，而是使用了更为传统的 @State。在 .onChanged 的闭包写法 { angle in self.angle = angle } 中，我们将最新的旋转角度数值赋值至参数 angle 中，以达到让系统所得手势参数更新自定义角度参数的目的。
 */
struct RotationGestureView: View {
    
    @State var angle = Angle(degrees: 0.0)
    
    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
    }
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: 200, height: 200)
            .rotationEffect(angle)
            .gesture(rotation)
        
    }
}


/**
 对于任意复杂手势来说，常见的用法是新建一个变量来代表你想要的手势，并将该变量放入 ​.gesture()​ 修改器中，以此来对视图增加该手势的支持。
 
 举个具体例子，如下图所示，我们希望让圆形视图支持缩放手势。此时可以先创建一个名为 ​magnification​ 的变量，接着使用 ​.gesture(magnification)​ 修改器来将「缩放手势」添加至圆形视图中。

 */
struct MagnificationGestureView: View {
    
    //  @GestureState 和我们之前学习的 @State 非常类似，唯独多了一个新功能，其用途是当手势完成时将变量参数恢复至初始值
    @GestureState var magnifBy = CGFloat(1.0)
    
    var magnification: some Gesture {
        MagnificationGesture()
            // 其中 gestureState 指的是当前手势中所存储的数值，比如缩放度为初始值 1；用户可能时刻在调整缩放幅度，currentState 指的是最新的缩放数据，比如 2.5；而 gestureState = currentState 这句指令目的，便是将最新的数据 currentState 赋给 gestureState，来更新手势中存储的数值状态。这段语法中的 transaction 是负责动画相关的参数，此处不必管。
            .updating($magnifBy) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: 200 * magnifBy, height: 200 * magnifBy)
            .gesture(magnification)
    }
}

struct TapGestureView: View {
    
    @State private var currentGesture = "无"
    @State private var images = ["hare", "tortoise", "cloud", "moon", "wind"]
    @State private var currentImageName = "questionmark"
    
    var body: some View {
        VStack {
            Text("识别出的手势: \(currentGesture)")
                .font(.largeTitle)
                .bold()
            
            Divider().padding()
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                Image(systemName: currentImageName)
                    .resizable()
                    .scaleEffect(0.3)
                    .scaledToFit()
            }
            .padding()
            .onTapGesture {
                currentImageName = images.randomElement()!
                currentGesture = "轻点"
            }
            
            Spacer()
            
        }
    }
}

struct LongPressedView: View {
    
    @State private var longPressed = false
    @State private var currentGesture = "无"
    
    var body: some View {
        VStack {
            Text("识别出的手势: \(currentGesture)")
                .font(.largeTitle)
                .bold()
            
            Divider().padding()
            
            RoundedRectangle(cornerRadius: 20)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(longPressed ? .orange : .blue)
                .padding()
            // 长按手势
                .onLongPressGesture {
                    currentGesture = "长按"
                    longPressed.toggle()
                }
        }
    }
}

struct GestureRelatedModifier_Previews: PreviewProvider {
    static var previews: some View {
        GestureRelatedModifier()
    }
}

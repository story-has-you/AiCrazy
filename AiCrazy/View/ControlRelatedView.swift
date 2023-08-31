//
//  ControlRelatedView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/8/30.
//

import SwiftUI
import MapKit

struct ControlRelatedView: View {
    
    var body: some View {
        ScrollView {
            HStack {
                ToggleView()
                ButtonView()
            }
            .padding(.bottom)
            
            PickerView()
            SliderView()
            StepperView()
            DatePickerView()
            
            HStack {
                ContextMenuView()
                ProgressViewView()
                MapView()
            }
            .padding(.bottom)

        }
    }
}

/**
 开关是应用设置中最常见的一类控件，其本身所关联的数据是布尔值 Bool，仅具备真和假两种状态。如下图所示，该开关处于开的状态，此时 SwiftUI 会将该状态记录在所对应的绑定变量中。
 
 ​其语法中的 ​@State var toggleValue = true ​ 指的是新建一个布尔值变量，用于存储用户输入的信息。​Toggle("自动登录", isOn: $toggleValue)​ 里，引号中的内容是开关对应的文字说明，​isOn​ 需要填写的是对应的绑定变量，让 SwiftUI 知道用户在拨动该开关后，需要更改哪个变量的值。此处，​isOn: $toggleValue​ 的意思是让变量 toggleValue 的值始终与界面上开关的状态同步。
 */
struct ToggleView: View {
    @State var toggleValue = true
    var body: some View {
        VStack(alignment: .leading) {
            Text("Toggle")
                .font(.headline)
            Toggle("自动登录", isOn: $toggleValue)
                .toggleStyle(SwitchToggleStyle())
                .tint(.blue)
        }
        .frame(height: 80)
        .cardStyle()
    }
}

/**
 用户使用按钮的目的是执行某些功能，如播放音乐。按钮的图案可以是前文所介绍的任意常见视图或其组合，比如图片、文字、图文组合等都可以作为按钮的外观。在上述语法中 ​label: {}​ 的花括号中放置按钮外观的代码，​action: {}​ 的花括号中放置按钮执行什么功能。比如下图的退出按钮，其外观是图标和文字的组合，用途是让用户退出登录。
 */
struct ButtonView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Button")
                .font(.headline)
            Button {
                
            } label: {
                Image(systemName: "person.crop.circle.fill.badge.minus")
                    .font(.system(size: 16, weight: .bold))
                Text("退出")
                    .bold()
            }
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(15)
        }
        .cardStyle()
    }
}

/**
 在选择器的语法中，pickerValue 指的是选择器所选中的值。以上图为例，若用户选择步行，则该值为 0；选择自行车，则该值为 1，依次类推。为了给选择器中的每一个选项提供说明，你还需要创建一个数组来提供文字，如 ​pickerOptions = ["步行", "自行车", "汽车"]​。最后用 ForEach 循环将文字填充给每个选项，选择器即书写完毕。

 在上图中，你还会注意到我为该选择器增加了一个修改器 ​.pickerStyle(SegmentedPickerStyle())​。它的作用是告诉 SwiftUI，我希望选择器直接将所有选项显示在界面上。若不加该修改器，则选择器会默认以二级菜单的方式来呈现，如 iOS 新建闹钟后，选择重复日期的界面。
 */
struct PickerView: View {
    
    @State var pickerValue = 0
    var pickerOptions = ["步行", "自行车", "汽车"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Picker")
                .font(.headline)
            Picker("Picker", selection: $pickerValue) {
                ForEach(0..<pickerOptions.count, id: \.self) { index in
                    Text(pickerOptions[index]).tag(index)
                }
                
            } // 希望选择器直接将所有选项显示在界面上。
            .pickerStyle(SegmentedPickerStyle())
        }
        .cardStyle()
    }
}



/**
滑动条也是应用程序中常被用到的设置选项之一。比如调节音乐播放进度、调节音量大小，或下图所示的调节屏幕亮度等，都是滑动条。根据需求，你可以将滑动条放在 HStack 中间，两边各放置一个图标，也可以额外放一个文本框来显示滑动条进度，用法取决于你的实际需求。

​在滑动条的写法中，你需要准备一个变量如 ​sliderValue​ 来记录进度，并给出一个范围如 ​in: -5...5​ 来告知 SwiftUI 滑动条左右两端所对应的数值。
*/
struct SliderView: View {
    
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Slider")
                .font(.headline)
            HStack {
                Image(systemName: "sun.min")
                Slider(value: $sliderValue, in: -5...5, step: 0.1)
                Image(systemName: "sun.max.fill")
            }
        }
        .cardStyle()
    }
}

/**
 与滑动条非常相似，梯度控制的用途也是让用户在一段数值中做调整。梯度控制更容易让用户精确控制数值，很适合用在偶尔需要改变，且被改变的值与当前值差异不大的情况。比如买门票是 1 张还是 张。反之，如用户调节音量时，可能一下子会调得很大声或完全关闭，此时用滑动条更合适。
 
 ​默认情况下，当用户点击梯度控制上的加号或减号时，数值变化为 1。若你希望其修改的值不为 1，可以使用另一个初始化器 ​Stepper(value: $stepperValue, in: -5...5,  step: 0.1) { "当前数值： \(stepperValue)" }​ 来进行更详尽的梯度设置，比如 ​step: 0.1​ 代表用户点击加号或减号的数值变化为 0.1。
 */
struct StepperView: View {
    
    @State var stepperValue = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stepper")
                .font(.headline)
            Stepper("当前数值： \(stepperValue)", value: $stepperValue, in: -5...5, step: 1)
        }
        .cardStyle()
    }
}

/**
 日期选择空间会被应用在不同场景中。如支持倒计时，支持定闹钟，或定时的提醒事项等，任何与时间有关的特性都可能涉及日期输入。SwiftUI 为我们提供的日期选择界面如下图右下角，用户可以点击日期或时间来对其进行精确修改。
 
 Apple 为我们提供了易用的结构 Date，其用途是处理与时间有关的信息。上述代码中新建变量 ​selectedDate​ 类型为 Date，用于用户记录用户输入的时间点。​dateRange​ 的花括号中的内容为预计算属性，用于提供用户可选日期的范围。​displayedComponents: [.hourAndMinute, .date] ​ 限定了用户输入的信息类型，如仅能输入日期或仅输入时间等，根据你的需求而定，本例中用户既可以输入日期，又可以输入时间。
 */
struct DatePickerView: View {
    
    
    @State var selectedDate = Date()
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: -100, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 100, to: Date())!
        return min...max
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date Picker")
                .font(.headline)
            DatePicker(selection: $selectedDate, in: dateRange, displayedComponents: [.hourAndMinute, .date]) {
                Text("截止日期")
            }
        }
        .cardStyle()
    }
}

/**
 长按菜单之前已经多次提及，其作用是为用户提供更多选项。比如当你在主屏幕上长按应用图标后，会出现分享或移除应用的选项，这弹出的便是长按菜单。
 
 长按菜单不仅可以被用在主屏幕的图标上，也可以被应用在应用中任何一个视图上。长按菜单应用在图标上的方法很简单，只需为视图添加修改器 ​.contextMenu {}​ 即可。该修改器中的花括号内所放置的是菜单选项，如按钮 ​Button("选项 A") {}​，按钮对应的花括号中可以放置按钮的用途，如复制信息、隐藏界面等。

 Apple 在跨平台应用开发的开发工具中付出了很大努力，来让整个工作流变得更易用。比如你在 iOS 或 iPadOS 应用中设置好的长按菜单，发布到 Mac 中会自动变为右键菜单，如下图所示。
 */
struct ContextMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Context")
                .font(.headline)
            VStack {
                Image(systemName: "ellipsis.circle.fill")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
                    .frame(width: 80, height: 80)
                Text("长按菜单")
                    .bold()
                    .foregroundColor(.blue)
            }
            .contextMenu {
                Button("选项 A") {
                    
                }
                Button("选项 B") {
                    
                }
            }
        }
        .frame(height: 120)
        .padding()
        .background(Color("WhiteDarkMode"))
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

/**
 载入状态严格意义上来说不算是控件，但因其标准形态和滑动条除了没有拖拽用的圆形按钮外完全一样，因此放在控件处一并介绍。Safari 浏览器中的下载界面，下载的进度条就是载入状态。载入状态的目的很简单，就是显示某数值所占总进度的百分比，比如上述代码中的 progressValue，若其值为 0.2，则载入状态进度条会显示十分之二的进度。
 
 ​除了长条形进度条外，圆形的载入界面也很常见。比如你在载入较大的照片时、网络刷新新消息时，可能都见过下图的界面。要显示该界面，只需在载入状态的代码后加上修改器  ​.progressViewStyle(CircularProgressViewStyle())​ 即可，此修改器理解为「进度条风格（圆形）」。
 */
struct ProgressViewView: View {
    
    @State var progressValue = 0.5
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pro")
                .font(.headline)
            Spacer()
            ProgressView(value: progressValue)
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
        .frame(height: 120)
        .padding()
        .background(Color("WhiteDarkMode"))
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.trailing)
    }
}

/**
 无论你的应用给出的是旅行建议还是商店评级等，直接给出地图视图都能让用户直观地了解到所在地周边信息。SwiftUI 将显示地图这件事大幅简化，你只需要给出经纬度即可显示对应区域，如下图所示。值得注意的是，Apple 框架中对应的地图框架为 MapKit，而给出地图坐标的 ​MKCoordinateRegion​ 是 MapKit 中的内容，因此使用地图时还需用代码 ​import MapKit​ 额外导入地图框架。
 */
struct MapView: View {
    
    
    @State var location = MKCoordinateRegion(center: .init(latitude: 39.9130, longitude: 116.3907), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Map")
                .font(.headline)
            Map(coordinateRegion: $location)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(15)
        }
        .frame(height: 120)
        .padding()
        .background(Color("WhiteDarkMode"))
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.trailing)
    }
}



struct ControlRelatedView_Previews: PreviewProvider {
    static var previews: some View {
        ControlRelatedView()
            .previewDisplayName("ControlRelatedView")
        ControlRelatedView()
            .previewDisplayName("ControlRelatedView Dark")
            .preferredColorScheme(.dark)
        
        
    }
}

// 用于打包常用修改器
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("WhiteDarkMode"))
            .cornerRadius(15)
            .shadow(radius: 3)
            .padding(.horizontal)
            .padding(.bottom)
    }
}


// 用于将打包好的修改器转化为易用函数
extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

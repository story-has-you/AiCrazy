//
//  ContentsRelatedView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/8/31.
//

import SwiftUI

struct ContentsRelatedView: View {

    var body: some View {
        TabView {
            ListView()
            GridView()
            FormView()
        }
        
    }
}

struct CardView: View {
    var body: some View {
        HStack {
            Image("icon")
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text("创作者的 iOS 独立开发指南")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)
                Spacer()
                Text("已进行：")
                    .font(.body)
                    .foregroundColor(.gray)
                Text("7 小时 20 分钟")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
                
        }
        .frame(height: 160)
        .padding()
        .background(Color("WhiteDarkMode"))
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.vertical, 5)
    }
}

struct ContentsRelatedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsRelatedView()
        CardView()
            .previewDisplayName("cardView")
    }
}

/**
 列表的语法是 ​List { }​，其中花括号区域放置子视图即可。我把上一篇文章中制作的子视图 CardView() 放置在列表中，结果如下图所示。子视图被从上至下罗列出来，中间还被添加了分割线。
 ​列表对子视图种类没有限制，你可以往里面添加任意视图，如 Text、VStack、Image、Button 等，甚至是如上图所示的自定义子视图 CardView 也可以。
 */
struct ListView: View {
    var body: some View {
        List {
            CardView()
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .tabItem {
            Image(systemName: "doc.append")
            Text("项目")
        }
    }
}


// 统计面板中的数值数据结构
struct Row: Identifiable, Hashable {
    var id = UUID()
    var label: String
    var image: String
    var value: String
    var unit: String
}

// 统计面板中的数值子视图
struct ValueView: View {
    var value: String
    var unit: String
    var size: CGFloat = 1
    
    var body: some View {
        HStack {
            Text(value).font(.system(size: 24 * size, weight: .bold, design: .rounded)) + Text(" \(unit)").font(.system(size: 14 * size, weight: .semibold, design: .rounded)).foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct GrayGroupBoxStyle<V: View>: GroupBoxStyle {
    
    var color: Color
    var destination: V
    var date: Date?
    
    func makeBody(configuration: Configuration) -> some View {
        NavigationLink(destination: destination) {
            GroupBox {
                HStack {
                    configuration.label.foregroundColor(color)
                    Spacer()
                    if date != nil {
                        Text("\(date!)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 4)
                    }
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.systemGray4))
                        .imageScale(.small)
                }
            } label: {
                configuration.content.padding(.top)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 LazyHGrid、LazyVGrid 便是本小节要介绍的重点，这两种视图仅有 Lazy 的版本，其用途是将内容按照网格的方式呈现。其中 LazyHGrid 代表着新增内容往水平方向无限扩展，LazyVGrid 代表着内容在水平方向碰到边界后，纵向往下延伸。以下图的播客应用为例，其使用的网格是 LazyVGrid，你可以看到内容在触碰到窗口边界时，换行并继续向下扩展。本小节将用纵向网格 LazyVGrid 举例。

 纵向网格的语法是 ​LazyVGrid(columns: rule, spacing: 20) { }​，其中 spacing 代表每个网格的格子之间要留多大空隙，columns 代表网格中每个格子的排版规则。排版规则需要填写的类型是数组 [GridItem]，如本例中的 ​let rule = [GridItem(.adaptive(minimum: 220))]​。
 
 排版规则指的是网格中，每个格子内容所获得位置的大小。排版规则共有三种，分别是：.adaptive(minimum:maximum:)、.fixed(_:) 、.flexible(minimum:maximum:)，具体使用场景如下：
 .adaptive
     不在乎每个格子可以分配到多大空间，但分配到的空间应在最大和最小值中间，此时我们不需要考虑一行共有几列，该数值由系统自动计算。
     比如网格的排版规则设置为 ​[GridItem(.adaptive(minimum: 210, maximum: 250))]​，设备的屏幕宽度为 1000，那么 SwiftUI 便会自动在屏幕边长允许的范围内放置尽可能多的格子，并在两侧自动留白，本例中一行可以排下 4 个格子，即生成 4 列。
     当然你也可以仅设置最小或最大值，剩下的交给 SwiftUI 来自行判断空间。如下图所示，我将网格规则设置为.adaptive，并提供最小值 220，SwiftUI 根据 iPad 宽度自动生成了四列的排布方式。此时若将 iPad 旋转至水平方向，则宽度变宽，SwiftUI 会自动将网格转为 6 列排布。
   
 .fixed(_:)
    指的是每一个格子只能分配这么大空间，你需要几列请明说。比如网格的排版规则设置为 ​[GridItem(.fixed(200))]​ 代表每行就一个格子，宽度为 200，只生成 1 列；
    [GridItem(.fixed(200)), GridItem(.fixed(200)), GridItem(.fixed(200))] 代表每行 3 个格子，宽度为 200，生成 3 列。
 
 .flexible(minimum:maximum:)
    指的是每一个格子只能分配此数值区间的任意大小，你需要几列要明说。比如 [GridItem(.fixed(200)), GridItem(. flexible(minimum: 200, maximum: 500))] 代表每行 2 个格子，生成 2 列。其中第一列格子宽度为 200，第二列格子宽度为 200 - 500 之间即可，具体宽度由系统决定。
 
 */
struct GridView: View {
    
    var columns = [
            GridItem(.adaptive(minimum: 200, maximum: 350), spacing: 15)
        ]
    
    var array: [Row] = [
            Row(label: "项目总用时", image: "clock", value: "50", unit: "分钟"),
            Row(label: "当前进行的项目", image: "circles.hexagonpath.fill", value: "3", unit: "个"),
            Row(label: "获得成就勋章", image: "star.fill", value: "5", unit: "枚"),
        ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(array) { row in
                        /*
                         成组框的外观由两部分组成，分别是上面的标签和底部的内容。它的语法为 ​GroupBox(label: Label("", systemImage: "")) { }​，其中参数 label 指的是我们之前学习的图标和文字的混合视图，花括号 { } 中可以放置卡片下方的内容，内容可以是任意视图或其组合。
                         */
                        GroupBox {
                            Label(row.label, systemImage: row.image)
                        } label: {
                            ValueView(value: row.value, unit: row.unit)
                        }
                        .groupBoxStyle(GrayGroupBoxStyle(color: .orange, destination: EmptyView()))
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("项目记录")
        }
        .tabItem {
            Image(systemName: "textformat.123")
            Text("统计")
        }
    }
}

/**
 表单常被使用在应用的设置中，比如下图中 iOS 的系统设置、闹钟时间和音量的调整等，用到的都是 Form 视图。若你的表单视图仅具备一些按钮或文字说明，这些内容不需要跳转至其他位置，则表单视图可以单独使用。若你的表单具备如下图所示的层级选项，你可以将整个表单视图放在导航器视图 NavigationView 中，来为这些设置提供层级关系。
 
 表单视图的语法为 ​Form { }​，你可以在花括号中放置任意子视图。为帮助我们整理表单中的内容，SwiftUI 还提供了帮助将内容转化为不同区块的 ​Section(header: )​ ，其中 header 参数后可以跟文本视图。

 在下图中，我将前几篇文章中学到的常用视图如文本，控制视图如开关和按钮，层级视图如导航器组合在一起，并通过信息视图组合在表单中。下图中的「每日目标，帮助与反馈」将表单中的区块说明，底部包含了一些按钮用于跳转至帮助文档。
 */
struct FormView: View {
    
    @State private var showReminderOnMainScreen = false
    @State private var sendOutNoticification = false
    var targetDurations = ["15 分钟", "30 分钟", "1 小时", "2 小时","3 小时"]
    @State private var selectedDuration = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $showReminderOnMainScreen) {
                        Text("显示目标")
                    }
                    Toggle(isOn: $sendOutNoticification) {
                        Text("推送提醒")
                    }
                } header: {
                    Text("每日目标")
                }
                
                Picker(selection: $selectedDuration) {
                    ForEach(0..<targetDurations.count, id: \.self) {
                        Text(self.targetDurations[$0])
                    }
                } label: {
                    Text("目标时长")
                }
                
                Section {
                    Button {
                        
                    } label: {
                        Text("帮助指南")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("提交反馈")
                    }
                    
                    
                } header: {
                    Text("帮助与反馈")
                }
            }
            .navigationTitle("设置")
        }
        .tabItem {
            Image(systemName: "gearshape")
            Text("设置")
        }
    }
}

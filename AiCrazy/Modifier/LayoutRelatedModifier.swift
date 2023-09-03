//
//  LayoutRelatedModifier.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/3.
//

import SwiftUI

struct LayoutRelatedModifier: View {
    
    @State var textFieldInput = ""
    @State var isHidden = true
    
    var body: some View {
        VStack {
            if !isHidden {
                TextField("文本款", text: $textFieldInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // 转化为占位符
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("大标题")
                                .font(.largeTitle)
                            Text("一些复杂的文本内容")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("大标题")
                                .font(.largeTitle)
                            Text("一些复杂的文本内容")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                    }
                    .redacted(reason: .placeholder)
                }
                Spacer()
                Toggle("Hide", isOn: $isHidden)
                    .labelsHidden()
            }
            
          
        }
    }
}

struct LayoutRelatedModifier_Previews: PreviewProvider {
    static var previews: some View {
        LayoutRelatedModifier()
    }
}

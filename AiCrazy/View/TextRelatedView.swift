//
//  TextRelatedView.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/8/30.
//

import SwiftUI

struct TextRelatedView: View {
    
    @State private var textFieldInput = ""
    @State private var secureFieldInput = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 100) {
            // 1.Text
            Text("Text 仅文本输入")
            // 2.标签 Label
            Label("Label 标签", systemImage: "square.stack")
            // 3.文本框 TextField
            TextField("TextField 文本框", text: $textFieldInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // 4.安全文本框 SecureField
            SecureField("SecureField 安全文本框", text: $secureFieldInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // 5.链接 Link
            Link("Link 点击跳转", destination: URL(string: "https://www.google.com")!)
            
        }
    }
    
    
    struct TextRelatedView_Previews: PreviewProvider {
        static var previews: some View {
            TextRelatedView()
        }
    }
    
}

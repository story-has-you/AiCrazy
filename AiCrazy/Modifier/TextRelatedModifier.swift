//
//  TextRelatedModifier.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/9/3.
//

import SwiftUI

struct TextRelatedModifier: View {
    
    @State private var textFieldInput = ""
    
    var body: some View {
        ScrollView {
            Group {
                // 动态字体
                Text("动态字体 .title")
                    .font(.title)
                
                Text("动态字体 .title2")
                    .font(.title2)
                
                Text("动态字体 .headline")
                    .font(.headline)
                
                Text("动态字体 .body")
                    .font(.body)
                
                Text("动态字体 .footnote")
                    .font(.footnote)
                
                
                Text("示例文本 Sample")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                
                Text("示例文本 Sample")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                Text("示例文本 Sample")
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                
                Text("示例文本 Sample")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
            }
            
            Group {
                // 字重
                Text("字重 .ultraLight")
                    .fontWeight(.ultraLight)
                
                Text("字重 .thin")
                    .fontWeight(.thin)
                
                Text("字重 .light")
                    .fontWeight(.light)
                
                Text("字重 .regular")
                    .fontWeight(.regular)
                
                Text("字重 .medium")
                    .fontWeight(.medium)
                
                Text("字重 .semibold")
                    .fontWeight(.semibold)
                
                Text("字重 .bold")
                    .fontWeight(.bold)
                
                Text("字重 .heavy")
                    .fontWeight(.heavy)
            }
            
            Group {
                //「长文本」相关修改器
                 Text("We see, then, that the disappearance of the conscious personality, the predominance of the unconscious personality, the turning by means of suggestion and contagion of feelings and ideas in an identical direction, the tendency to immediately transform the suggested ideas into acts; these, we see, are the principal characteristics of the individual forming part of a crowd. He is no longer himself, but has become an automaton who has ceased to be guided by his will.")
                     .lineLimit(5)
                     .truncationMode(.middle)
                     .lineSpacing(10.0)
                     .allowsTightening(true)
                     .minimumScaleFactor(0.5)
                     .multilineTextAlignment(.leading)
                
               //「文本框」相关修改器
               TextField("文本框", text: $textFieldInput)
                   .textFieldStyle(RoundedBorderTextFieldStyle()) // 文本框外形风格
                   .autocapitalization(.sentences) // 自动大小写。常见的有 .words 自动为每个单词首字母大写，.sentence 自动为输入的句子句首大写等。本小节开头图中展示的是句子首字母大写的参数。
                   .disableAutocorrection(true) // 自动纠错开关。若此处为 true，则用户输入的文本内容不会被自动纠错。该修改器很适合用户输入用户名等信息时使用，因为用户名很可能不是规则的单词，自动纠错反而会越纠越错。
                   .textContentType(.emailAddress) // 联想内容类型。比如用户输入信息时，iOS 键盘上方可能会自动出现一些预测性文字，若用户在敲击邮件时，可能会出现 「@」  符号等，此时便都需要开发者指定到底需要预测什么。
                   .keyboardType(.emailAddress) //键盘类型。比如用户输入电话号码时，他们提供一个只能输入电话号码的键盘；当用户输入邮件时，最好提供一个临时隐藏除 「@」 外其他特殊符号的键盘，从源头上避免用户输入错误信息。
            }
        }
    }
}

struct TextRelatedModifier_Previews: PreviewProvider {
    static var previews: some View {
        TextRelatedModifier()
    }
}

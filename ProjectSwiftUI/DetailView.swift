//
//  DetailView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct DetailView: View {
    let title: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("这是 \(title)")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // 增强自定义返回按钮
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.backward")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.black, Color.blue.opacity(0.3))
                            .font(.system(size: 22))
                    }
                }
            }
        }
    }
}


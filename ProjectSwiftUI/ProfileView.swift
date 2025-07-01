//
//  ProfileView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
        
    var body: some View {
        Form {
            Section(header: Text("账户信息")) {
                NavigationLink(destination: DetailView(title: "个人信息")) {
                    Text("查看个人信息")
                }
                
                NavigationLink(destination: DetailView(title: "设置")) {
                    Text("应用设置")
                }
            }
            
            Section(header: Text("偏好设置")) {
                Toggle("显示标题", isOn: $appState.showNavigationBarTitle.animation())
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                Picker("主题颜色", selection: .constant(0)) {
                    Text("蓝色").tag(0)
                    Text("绿色").tag(1)
                    Text("橙色").tag(2)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

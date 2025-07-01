//
//  NotificationsView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject private var appState: AppState
        
    var body: some View {
        List {
            ForEach(0..<10) { index in
                NavigationLink(destination: DetailView(title: "通知详情 \(index + 1)")) {
                    VStack(alignment: .leading) {
                        Text("通知 \(index + 1)")
                            .font(.headline)
                        Text("这是通知的详细描述内容")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

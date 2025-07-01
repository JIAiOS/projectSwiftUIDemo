//
//  SearchView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var appState: AppState
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            TextField("搜索内容...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            List(1..<15) { item in
                NavigationLink(destination: DetailView(title: "搜索结果 \(item)")) {
                    Text("搜索结果 \(item)")
                }
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

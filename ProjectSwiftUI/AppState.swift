//
//  AppState.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import Foundation

class AppState: ObservableObject {
    @Published var currentTab: Tab = .home
    @Published var showNavigationBarTitle = false
    struct NavigationStackIdentifier: Hashable {}
    
    enum Tab: CaseIterable {
    case home, search, notifications, profile
        var title: String {
            switch self {
            case .home: return "首页"
            case .search: return "探索"
            case .notifications: return "通知"
            case .profile: return "我的"
            }
        }
        var icon: String {
            switch self {
            case .home: return "house.fill"
            case .search: return "magnifyingglass"
            case .notifications: return "bell.fill"
            case .profile: return "person.crop.circle"
            }
        }
    }
}

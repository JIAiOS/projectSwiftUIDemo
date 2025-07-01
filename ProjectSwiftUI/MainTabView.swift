//
//  MainTabView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        TabView(selection: $appState.currentTab) {
            NavigationView {
                HomeView()
                    .environmentObject(appState)
                    .environment(\.managedObjectContext, CoreDataManager.shared.content)
                    .conditionalNavigationBarTitle(title: appState.currentTab.title, displayMode: .inline, isVisible: appState.showNavigationBarTitle)
            }
            .tabItem { tabItem(for: .home) }
            .tag(AppState.Tab.home)
            
            NavigationView {
                SearchView()
                    .conditionalNavigationBarTitle(title: appState.currentTab.title, displayMode: .inline, isVisible: appState.showNavigationBarTitle)
            }
            .tabItem {
                tabItem(for: .search)
            }
            .tag(AppState.Tab.search)
            
            NavigationView {
                NotificationsView()
                    .conditionalNavigationBarTitle(title: appState.currentTab.title, displayMode: .inline, isVisible: appState.showNavigationBarTitle)
            }
            .tabItem {
                tabItem(for: .notifications)
            }
            .tag(AppState.Tab.notifications)
            
            NavigationView {
                ProfileView()
                    .conditionalNavigationBarTitle(title: appState.currentTab.title, displayMode: .inline, isVisible: appState.showNavigationBarTitle)
            }
            .tabItem {
                tabItem(for: .profile)
            }
            .tag(AppState.Tab.profile)
        }
        .environmentObject(appState)
        .accentColor(.blue)
        .onAppear {
            // 设置TabBar外观
            setupTabBarAppearance()
        }
    }
    
    private func tabItem(for tab: AppState.Tab) -> some View {
        VStack {
            Image(systemName: tab.icon)
            Text(tab.title)
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - 视图扩展：可选标题修饰符
extension View {
    /// 有条件地显示导航栏标题
    func conditionalNavigationBarTitle(
        title: String,
        displayMode: NavigationBarItem.TitleDisplayMode = .inline,
        isVisible: Bool = true
    ) -> some View {
        self.modifier(ConditionalNavigationTitleModifier(
            title: title,
            displayMode: displayMode,
            isVisible: isVisible
        ))
    }
}

struct ConditionalNavigationTitleModifier: ViewModifier {
    let title: String
    let displayMode: NavigationBarItem.TitleDisplayMode
    let isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .if(isVisible) { view in
                view.navigationBarTitle(title, displayMode: displayMode)
            }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AppState())
    }
}

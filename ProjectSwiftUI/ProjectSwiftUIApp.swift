//
//  ProjectSwiftUIApp.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/28.
//

import SwiftUI
import CoreData

@main
struct ProjectSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // 隐藏系统返回按钮文字
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
            UIOffset(horizontal: -1000, vertical: 0),
            for: .default
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let _ = CoreDataManager.shared.content
        
        return true
    }
}





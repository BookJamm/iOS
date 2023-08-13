//
//  AppDelegate.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/08.
//

import SwiftUI
import UIKit

import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Tabbar 배경 컬러 지정
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            let tabBar = UITabBar()
            appearance.configureWithOpaqueBackground()
            appearance.selectionIndicatorTintColor = .white
            
            tabBar.standardAppearance = appearance;
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Kakao
        KakaoSDK.initSDK(appKey: "e71c9521872b70f64acf3a7139889342")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

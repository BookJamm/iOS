//
//  SceneDelegate.swift
//  BookJam
//
//  Created by YOUJIM on 11/7/23.
//

import UIKit

@available(iOS 16.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
//        window.inputViewController?.view.backgroundColor = .white
        
        // MARK: 앱 시작시 처음 보여질 ViewController 설정
        /// 로그인 또는 회원가입 화면으로 전환할 때 네비게이션 바 표시를 위한 네비게이션 컨트롤러를 rootViewController로 설정
        let rootNavigationController = UINavigationController(rootViewController: LocationViewController())
        /// 네비게이션 바 컴포넌트 색상을 검정색으로 설정
//        rootNavigationController.navigationBar.tintColor = .black
        
        self.window?.rootViewController = rootNavigationController
        
        /// 모든 View의 배경색을 흰색으로 설정
//        UIView.appearance().backgroundColor = .white
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


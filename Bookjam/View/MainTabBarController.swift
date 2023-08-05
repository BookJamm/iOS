//
//  MainTabBarController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/05.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = main03
        
        let mainVC = MainPageVC()
        let locationVC = LocationVC()
        let feedVC = FeedVC()
        let mypageVC = MyPageVC()
        
        mainVC.title = "메인"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        locationVC.title = "내 주변"
        locationVC.tabBarItem.image = UIImage(systemName: "map.fill")
        locationVC.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        feedVC.title = "피드"
        feedVC.tabBarItem.image = UIImage(systemName: "ellipsis.message.fill")
        feedVC.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
        
        mypageVC.title = "마이"
        mypageVC.tabBarItem.image = UIImage(systemName: "person.fill")
        mypageVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let locationNavigationController = UINavigationController(rootViewController: locationVC)
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let mypageNavigationController = UINavigationController(rootViewController: mypageVC)
        
        [
            mainNavigationController,
            locationNavigationController,
            feedNavigationController,
            mypageNavigationController
        ].forEach {
            $0.isNavigationBarHidden = true
        }
        
        setViewControllers([mainNavigationController,
                            locationNavigationController,
                            feedNavigationController,
                            mypageNavigationController], animated: true)
    }
}

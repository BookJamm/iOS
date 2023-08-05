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
        
        let mainVC = MainPageVC()
        let locationVC = LocationVC()
        let feedVC = FeedVC()
        let mypageVC = MyPageVC()
        
        mainVC.title = "메인"
        locationVC.title = "내 주변"
        feedVC.title = "피드"
        mypageVC.title = "마이"
        
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
            $0.navigationItem.title = ""
        }
        
        if let items = tabBar.items {
            items [0].selectedImage = UIImage (systemName: "house.fill")
            items[0].image = UIImage (systemName: "house")
            items[0].title = "메인"
            items [1].selectedImage = UIImage (systemName: "map.fill")
            items [1].image = UIImage (systemName: "map")
            items[1].title = "내 주변"
            items [2].selectedImage = UIImage (systemName: "ellipsis.message.fill")
            items [2].image = UIImage (systemName: "ellipsis.message")
            items[2].title="피드"
            items [3].selectedImage = UIImage (systemName: "person.fill")
            items [3].image = UIImage (systemName: "person")
            items[3].title="마이"
        }
        
        setViewControllers([mainNavigationController,
                            locationNavigationController,
                            feedNavigationController,
                            mypageNavigationController], animated: false)
    }
}

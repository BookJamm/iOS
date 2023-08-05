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
        
        [
            mainVC,
            locationVC,
            feedVC,
            mypageVC
        ].forEach { $0.navigationItem.largeTitleDisplayMode = .always }
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let locationNavigationController = UINavigationController(rootViewController: locationVC)
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let mypageNavigationController = UINavigationController(rootViewController: mypageVC)
        
        setViewControllers([mainNavigationController,
                            locationNavigationController,
                            feedNavigationController,
                            mypageNavigationController], animated: false)
    }
}

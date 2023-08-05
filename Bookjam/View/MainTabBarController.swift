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
        
        // MARK: Variables
        
        let mainVC = MainPageVC()
        mainVC.title = "메인"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let locationVC = LocationVC()
        locationVC.title = "내 주변"
        locationVC.tabBarItem.image = UIImage(systemName: "map.fill")
        locationVC.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        let feedVC = FeedVC()
        feedVC.title = "피드"
        feedVC.tabBarItem.image = UIImage(systemName: "ellipsis.message.fill")
        feedVC.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
        
        let mypageVC = MyPageVC()
        mypageVC.title = "마이"
        mypageVC.tabBarItem.image = UIImage(systemName: "person.fill")
        mypageVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        let titleButton = UIBarButtonItem(image: UIImage(named: "BookJamLogoMainColor"),
                                          style: .plain,
                                          target: self,
                                          action: .none)
        
        // TODO: 나중에 action 메소드 만들어서 수정
        let alertButton = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                          style: .plain,
                                          target: self,
                                          action: .none)
        
        // TODO: 나중에 action 메소드 만들어서 수정
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                            style: .plain,
                                            target: self,
                                            action: .none)
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let locationNavigationController = UINavigationController(rootViewController: locationVC)
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let mypageNavigationController = UINavigationController(rootViewController: mypageVC)
        
        
        // MARK: Navigation Bar 커스텀
        
        [
            mainVC,
            locationVC,
            feedVC,
            mypageVC
        ].forEach {
            $0.title = ""
            $0.navigationItem.leftBarButtonItem = titleButton
            $0.navigationItem.leftBarButtonItem?.tintColor = main03
            $0.navigationItem.setRightBarButtonItems([alertButton, settingButton], animated: true)
            $0.navigationItem.rightBarButtonItems![0].tintColor = .black
            $0.navigationItem.rightBarButtonItems![1].tintColor = .black
            
        }
        
        setViewControllers([mainNavigationController,
                            locationNavigationController,
                            feedNavigationController,
                            mypageNavigationController], animated: true)
    }
}

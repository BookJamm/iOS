//
//  MainPageInfoViewController.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/21.
//

import UIKit

class MainPageInfoViewController: UIViewController {

    var infoView: UIView = UIView().then{
        
        $0.backgroundColor = gray02
        
        let label = UILabel()
        label.text = "독립 서점은 대규모 자본, 큰 유통망에 의지하지 않고 꾸며진 작은 서점을 의미해요 :)"
        label.textColor = .black
        label.numberOfLines = 0 // Allow multiple lines
        label.textAlignment = .left
        label.font = paragraph06
        label.sizeToFit()
        
        $0.addSubview(label)

    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow 적용하기 위한 containerView
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 1
        containerView.addSubview(infoView)
        
        // infoView 모서리 둥글게 만들기
        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true
        view.addSubview(containerView)
        
        // containerView 에 대해 Auto Layout 설정
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 315).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 367).isActive = true
    }
    

}

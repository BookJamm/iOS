//
//  LoginViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/09.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit


class LoginViewController: UIViewController {
    
    let logoImage = UIImageView()
    let signUpButton = UIButton()
    let emailButton = UIButton()
    let kakaoButton = UIButton()
    let appleButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "MainColor")
        
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(emailButton)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
        
        logoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        
    }
    
    func setUpConstraint() {
        
    }
    

}

struct LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

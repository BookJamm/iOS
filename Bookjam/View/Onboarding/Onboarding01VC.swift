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
import Then


class Onboarding01VC: UIViewController {
    
    
    // MARK: Variables
    
    let logoImage = UIImageView().then {
        $0.image = UIImage(named: "BookJamLogo")
    }
    
    // TODO: 디자인 끝나면 애플 로그인 버튼 구현
    
    let appleButton = UIButton()
    
    let emailButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitle("북잼 로그인", for: .normal)
        $0.setTitleColor(UIColor(named: "MainColor"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    
    let kakaoButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "KakaoColor")
        $0.setImage(UIImage(named: "KakaoLogo"), for: .normal)
        $0.setTitle(" 카카오 계정 연동하기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "191919"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    
    let signUpButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = UIColor(named: "MainColor")
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(emailButton)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.45)
        }
        
        emailButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.625)
        }
        
        signUpButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.775)
        }
    }
}

struct Onboarding01VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding01VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

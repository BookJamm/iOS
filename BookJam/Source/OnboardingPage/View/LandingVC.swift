//
//  ViewController.swift
//  BookJam
//
//  Created by YOUJIM on 11/7/23.
//

import AuthenticationServices
import UIKit

import SnapKit
import Then

class LandingVC: UIViewController {
    
    // MARK: Variables
    
    let logoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "BookjamLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    // TODO: 캐러셀 CollectionView로 구현
    
    let kakaoLoginButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "FEE500")
        $0.setImage(UIImage(named: "KakaoLogo"), for: .normal)
        $0.setTitle(" 카카오 계정 연동하기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "191919"), for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didKakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    let appleLoginButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton().then {
        $0.addTarget(self, action: #selector(didAppleLoginButtonTapped), for: .touchUpInside)
    }
    
    let localLoginButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.setTitle("북잼 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didLocalLoginButtonTapped), for: .touchUpInside)
    }
    
    let localSignUpButton: UIButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didLocalSignUpButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    private func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    private func setUpLayout() {
        [
            logoImageView,
            kakaoLoginButton,
            appleLoginButton,
            localLoginButton,
            localSignUpButton
        ].forEach { view.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    private func setUpConstraint() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(111)
        }
        
        localSignUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-52)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
        }
        
        localLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(localSignUpButton.snp.top).offset(-8)
            $0.left.right.height.equalTo(localSignUpButton)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(localLoginButton.snp.top).offset(-8)
            $0.left.right.height.equalTo(localSignUpButton)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-8)
            $0.left.right.height.equalTo(localSignUpButton)
        }
    }
    
    
    // MARK: Functions
    
    /// 카카오 로그인 로직 담을 함수입니다.
    @objc func didKakaoLoginButtonTapped() {
        
    }
    
    /// 애플 로그인 로직 담을 함수입니다.
    @objc func didAppleLoginButtonTapped() {
        
    }
    
    /// 로컬 로그인 로직 담을 함수입니다.
    @objc func didLocalLoginButtonTapped() {
        
    }
    
    /// 로컬 회원가입 로직 담을 함수입니다.
    @objc func didLocalSignUpButtonTapped() {
        
    }
}


import SwiftUI
@available(iOS 16.0, *)
struct LandingVC_Preview: PreviewProvider {
    static var previews: some View {
        LandingVC().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}


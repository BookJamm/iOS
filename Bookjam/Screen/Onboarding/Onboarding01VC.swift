//
//  LoginViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/09.
//

// MARK: - 앱 시작하자마자 뜨는 로그인 화면

import AuthenticationServices
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
    
    let emailButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitle("북잼 로그인", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didEmailButtonTapped), for: .touchUpInside)
    }
    
    let kakaoButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "KakaoColor")
        $0.setImage(UIImage(named: "KakaoLogo"), for: .normal)
        $0.setTitle(" 카카오 계정 연동하기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "191919"), for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didKakaoButtonTapped), for: .touchUpInside)
    }
    
    let signUpButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.addTarget(self, action: #selector(didSignUpButtonTapped), for: .touchUpInside)
    }
    
    let appleButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton().then {
        $0.addTarget(self, action: #selector(didAppleButtonTapped), for: .touchUpInside)
    }
    
    /// 임시로 메인 바로 넘어갈 수 있게 만들어 둔 버튼입니다.
    /// 데모데이 이전에 개발 완료하면 삭제할 예정입니다.
    let skipButton: UIButton = UIButton().then {
        $0.setTitle("메인으로 넘어가기", for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.addTarget(self, action: #selector(didSkipButtonTapped), for: .touchUpInside)
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
        view.backgroundColor = main01
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(emailButton)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
        view.addSubview(skipButton)
    }
    
    
    // MARK: Constraints
    
    func setUpConstraint() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(270)
        }
        
        emailButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-8)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
            $0.bottom.equalTo(kakaoButton.snp.top).offset(-8)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
            $0.bottom.equalTo(appleButton.snp.top).offset(-8)
        }
        
        appleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-102)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: Functions
    
    // 북잼 로그인 버튼 누르면 로그인 화면으로 넘어가게 구현
    @objc func didEmailButtonTapped() {
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    // 회원가입 버튼 누르면 회원가입 화면(Onboarding02VC)로 넘어가게 구현
    // signUpButton addTarget으로 설정됨
    @objc func didSignUpButtonTapped() {
        navigationController?.pushViewController(Onboarding03VC(), animated: true)
    }
    
    // 카카오 계정 연동하기 버튼 누르면 카카오 연동하는 화면 뜨게 구현
    // kakaoButton addTarget으로 설정됨
    // 기능은 아직 구현 안됨
    // TODO: 서버랑 연동해서 로그인 기능 연동하기
    @objc func didKakaoButtonTapped() {
        print("loginKakao() called.")
        
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // 회원가입 성공 시 oauthToken 저장가능하다
                    // _ = oauthToken
                    
                    // 사용자정보를 성공적으로 가져오면 화면전환 한다.
                    //                    self.getUserInfo()
                }
            }
        }
        // 카카오톡 미설치
        else {
            print("카카오톡 미설치")
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("카카오톡 팝업 웹뷰 띄우기")
                    
                    _ = oauthToken
                }
            }
        }
    }
    
    @objc func didSkipButtonTapped() {
        let mainPage = TabBarController()
        mainPage.modalPresentationStyle = .fullScreen
        mainPage.modalTransitionStyle = .coverVertical
        
        self.present(mainPage, animated: true, completion: nil)
    }
}//end of Onboarding01VC

// MARK: Extension

// 애플 로그인 기능 구현을 위한 ASAuthorizationController Delegate와 ContextProviding extension 구현
extension Onboarding01VC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    // Apple로 로그인 버튼 누르면 계정 인증되도록 구현
    // appleButton addTarget으로 설정
    @objc func didAppleButtonTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
          let request = appleIDProvider.createRequest()
          request.requestedScopes = [.fullName, .email]
            
          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
          authorizationController.delegate = self
          authorizationController.presentationContextProvider = self
          authorizationController.performRequests()
    } // end of didAppleButtonTapped()
    
    // 애플 인증 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        print("Apple ID Credential Authorization User ID : \(appleIDCredential.user)")
        
        // 일단 화면 전환만 가능하게 설정
        navigationController?.pushViewController(Onboarding04VC(), animated: true)
        
        // TODO: 서버랑 연결해서 정보 넘기고 메인으로 전환까지 진행
        // 회원이면 로그인 처리하고 메인으로 전환
        // 회원 아니면 온보딩 04로 연결해서 가입 진행
    }
    
    // 애플 인증 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple ID Credential failed with error : \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

//struct Onboarding01VC_Preview: PreviewProvider {
//    static var previews: some View {
//        Onboarding01VC().toPreview()
//    }
//}

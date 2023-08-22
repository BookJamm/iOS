//
//  LoginVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class LoginVC: UIViewController {

    // MARK: Variables
    
    private var isAutoLogin: Bool = false
    
    var loginLabel: UILabel = UILabel().then {
        $0.text = "로그인"
        $0.font = title01
        $0.textColor = .black
    }
    
    var emailLabel: UILabel = UILabel().then {
        $0.text = "이메일 입력"
        $0.font = title03
        $0.textColor = gray07
    }
    
    var emailTextField: UITextField = UITextField().then {
        $0.placeholder = "email@email.com"
        $0.font = paragraph01
    }
    
    var emailUnderLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var passwordLabel: UILabel = UILabel().then {
        $0.text = "비밀번호 입력"
        $0.font = title03
        $0.textColor = gray07
    }
    
    var passwordTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호 입력"
        $0.isSecureTextEntry = true
        $0.font = paragraph01
    }
    
    var passwordUnderLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var checkLabel: UILabel = UILabel().then {
        $0.text = "사용자가 없거나 비밀번호가 일치하지 않습니다."
        $0.font = captionText03
        $0.textColor = alert
        $0.isHidden = true
    }
    
    var checkBoxButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        $0.tintColor = main01
        $0.addTarget(self, action: #selector(didCheckBoxButtonTapped), for: .touchUpInside)
    }
    
    var autoLoginLabel: UILabel = UILabel().then {
        $0.text = "자동 로그인"
        $0.font = captionText01
        $0.textColor = gray07
    }
    
    var findEmailAndPasswordLabel: UIButton = UIButton().then {
        $0.setTitle("이메일 / 비밀번호 찾기", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.titleLabel?.font = captionText01
    }
    
    var loginButton: UIButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            loginLabel,
            emailLabel,
            emailTextField,
            emailUnderLineView,
            passwordLabel,
            passwordTextField,
            passwordUnderLineView,
            checkLabel,
            autoLoginLabel,
            checkBoxButton,
            findEmailAndPasswordLabel,
            loginButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(60)
            $0.leading.equalTo(loginLabel.snp.leading)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(26)
            $0.leading.equalTo(emailLabel.snp.leading)
        }
        
        emailUnderLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(emailTextField.snp.bottom).offset(13)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailUnderLineView.snp.bottom).offset(15)
            $0.leading.equalTo(emailUnderLineView.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(26)
            $0.leading.equalTo(passwordLabel.snp.leading)
        }
        
        passwordUnderLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(13)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(passwordUnderLineView.snp.bottom).offset(12)
            $0.leading.equalTo(passwordUnderLineView.snp.leading)
        }
        
        checkBoxButton.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(20)
            $0.leading.equalTo(checkLabel.snp.leading)
        }
        
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBoxButton.snp.centerY)
            $0.leading.equalTo(checkBoxButton.snp.trailing).offset(10)
        }
        
        findEmailAndPasswordLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBoxButton.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(findEmailAndPasswordLabel.snp.bottom).offset(20)
            $0.leading.equalTo(checkBoxButton.snp.leading)
            $0.trailing.equalTo(findEmailAndPasswordLabel.snp.trailing)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Function
    
    @objc func didCheckBoxButtonTapped() {
        isAutoLogin.toggle()
        if isAutoLogin == true { checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) }
        else { checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal) }
    }
    
    @objc func didLoginButtonTapped() {
        var email = emailTextField.text ?? ""
        var password = passwordTextField.text ?? ""
        
        // MARK: 로그인 API 연결
        APIManager.shared.postData(
            urlEndpointString: Constant.postAuthLogin,
            responseDataType: APIModel<userLoginResponseModel>?.self,
            requestDataType: userLoginRequestModel.self,
            parameter: userLoginRequestModel(email: email, password: password),
            completionHandler: {
                response in
                if let code = response?.code {
                    /// 로그인 성공하면
                    if code == 1000 {
                        /// 유저 정보 담는 싱글톤 객체에 이메일 저장
                        /// ID 저장해야 하는 것 같은데 ... ID 반환을 안해줌
                        let userInfo = UserInfo.shared
                        userInfo.user.email = email
                        
                        /// 메인으로 화면 전환
                        let mainPage = TabBarController()
                        mainPage.modalPresentationStyle = .fullScreen
                        mainPage.modalTransitionStyle = .coverVertical
                        
                        self.present(mainPage, animated: true, completion: nil)
                    }
                    /// 로그인 실패하면 로그인 실패 라벨 숨김 상태 해제
                    else {
                        self.checkLabel.isHidden = false
                    }
                }
            })
    }
    
}

//struct LoginVC_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}


//
//  Onboarding03VC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/15.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class Onboarding03VC: UIViewController {
    
    // MARK: Variables
    
    var emailCheck: Bool = false
    
    let registerLabel: UILabel = UILabel().then {
        $0.text = "회원 가입"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    let idLabel: UILabel = UILabel().then {
        $0.text = "아이디 입력"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = UIColor(hexCode: "6F6F6F")
    }
    
    let passwordLabel: UILabel = UILabel().then {
        $0.text = "비밀번호 입력"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = UIColor(hexCode: "6F6F6F")
    }
    
    let emailTextField: UITextField = UITextField().then {
        $0.placeholder = "email@email.com"
    }
    
    let passwordTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호 입력"
        $0.isSecureTextEntry = true
    }

    let passwordConfirmTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.isSecureTextEntry = true
    }
    
    let idDuplicateLabel: UILabel = UILabel().then {
        $0.isHidden = true
        $0.text = "중복된 아이디입니다."
        $0.textColor = UIColor(hexCode: "F22222")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let passwordConditionLabel: UILabel = UILabel().then {
        $0.text = "영대문자, 영소문자, 숫자, 특수문자 중 3가지 이상 포함 9자 이상"
        $0.textColor = UIColor(hexCode: "F22222")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let passwordAccordLabel: UILabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = UIColor(hexCode: "F22222")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    // 중복확인 버튼
    let duplicateRequestButton: UIButton = UIButton().then {
        $0.setTitle("중복 확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    // 다음으로 버튼
    let nextButton: UIButton = UIButton().then {
        $0.setTitle("다음으로", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.backgroundColor = .gray
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(didNextButtonTapped), for: .touchDown)
    }
    
    let bottomLineView: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    
    let bottomLineView2: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    
    let bottomLineView3: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        
        self.passwordTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.passwordConfirmTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        hideKeyboard() // 화면 밖 클릭하면 키보드 내려가게 설정
    }
    
    
    // MARK: Layout
    
    func setUpLayout(){
        self.view.addSubview(registerLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordConfirmTextField)
        self.view.addSubview(idDuplicateLabel)
        self.view.addSubview(passwordConditionLabel)
        self.view.addSubview(passwordAccordLabel)
        self.view.addSubview(duplicateRequestButton)
        self.view.addSubview(nextButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(bottomLineView2)
        self.view.addSubview(bottomLineView3)
    }
    
    
    // MARK: Constraints

    func setUpConstraint(){
        registerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        idLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.31)
            $0.centerY.equalToSuperview().multipliedBy(0.45)
        }
        
        emailTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview().multipliedBy(0.82)
            $0.centerY.equalToSuperview().multipliedBy(0.58)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.68)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview().multipliedBy(0.77)
            $0.centerY.equalToSuperview().multipliedBy(0.637)
        }
        
        duplicateRequestButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.22)
            $0.height.equalToSuperview().multipliedBy(0.055)
            $0.right.equalToSuperview().multipliedBy(0.97)
            $0.centerY.equalToSuperview().multipliedBy(0.584)
        }
        
        idDuplicateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.35)
            $0.centerY.equalToSuperview().multipliedBy(0.69)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.34)
            $0.centerY.equalToSuperview().multipliedBy(0.87)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview().multipliedBy(0.82)
            $0.centerY.equalToSuperview()
        }
        
        bottomLineView2.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.915)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.53)
        }
        
        passwordConditionLabel.snp.makeConstraints {
            $0.leftMargin.equalToSuperview().multipliedBy(1.6)
            $0.bottom.equalToSuperview().multipliedBy(0.566)
        }
        
        passwordConfirmTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview().multipliedBy(0.82)
            $0.bottom.equalToSuperview().multipliedBy(0.67)
        }
        
        bottomLineView3.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.915)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.65)
        }
        
        passwordAccordLabel.snp.makeConstraints {
            $0.leftMargin.equalToSuperview().multipliedBy(1.6)
            $0.bottom.equalToSuperview().multipliedBy(0.688)
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    } //end of setUpConstraint
    
    
    // MARK: Functions
    
    @objc func didNextButtonTapped() {
        navigationController?.pushViewController(Onboarding04VC(), animated: true)
    } // end of didNextButtonTapped()
    
    //비밀번호 일치 여부 확인
    @objc func isSamePassword(_ first: UITextField, _ second: UITextField) -> Bool{
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    } //end of isSamePassword
    
    //텍스트 필드 입력값 변하면 유효성 검사
    @objc func TFdidChanged(_ sender: UITextField) {
        
        print("텍스트 변경 감지")
        print("text :", sender.text ?? "error")
        
        // 비밀번호 조건문 정규식
        let passwordRegex = "^(?=(?:[^A-Z]*[A-Z]){0,1})(?=(?:[^a-z]*[a-z]){0,1})(?=(?:\\D*\\d){0,1})(?=(?:[^@$!%*?&]*[@$!%*?&]){0,1}).{9,}$"


        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        // Check if the password matches the condition
        let isPasswordValid = passwordPredicate.evaluate(with: self.passwordTextField.text)
        
        //Check if the 3 textfields are filled in and if the passwords match.
        if !(emailCheck) && isPasswordValid{
            if !(self.passwordTextField.text?.isEmpty ?? true) && isSamePassword(passwordTextField, passwordConfirmTextField) && isPasswordValid {
                updateNextButton(willActive: true)
                passwordAccordLabel.textColor = UIColor(hexCode: "00C950")
                passwordAccordLabel.text = "비밀번호가 일치합니다."
            } else {
                updateNextButton(willActive: false)
                passwordAccordLabel.textColor = UIColor(hexCode: "F22222")
                passwordAccordLabel.text = "비밀번호가 일치하지 않습니다."
            }
        }

        
    }//end of T'Fdid'Changed
    
    //'다음으로'버튼 활성화/비활성화
    func updateNextButton(willActive: Bool) {
            
            if(willActive == true) {
                //다음 버튼 색 변경
                self.nextButton.backgroundColor = UIColor(named: "MainColor")
                //다음 페이지 연결
                print("다음 버튼 활성화")
                nextButton.isEnabled = true
                
            } else {
                //다음 버튼 색 변경
                self.nextButton.backgroundColor = .gray
                //다음 페이지 연결 해제
                print("다음 버튼 비활성화")
                nextButton.isEnabled = false
            }
        }
}

struct Onboarding03VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding03VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

//  OnBoarding_02A_VC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/13.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class Onboarding02VC: UIViewController {
    
    // MARK: Variables
    
    let label1: UILabel = UILabel().then {
        $0.text = "회원가입을 위한 전화번호를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    let label2: UILabel = UILabel().then {
        $0.text = "원활한 BOOKJAM 서비스 이용을 위해\n최초 1회 인증이 필요합니다."
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 2
    }
    
    // 전화번호 입력 텍스트 필드
    let phoneNumberTextField: UITextField = UITextField().then {
        $0.placeholder = "000 0000 0000"
    }
    
    // 인증번호 입력 텍스트 필드
    let verifyTextField: UITextField = UITextField().then {
        $0.placeholder = "인증번호 입력"
    }
    
    // 인증요청 버튼
    let certifyRequestButton: UIButton = UIButton().then {
        $0.setTitle("인증 요청", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    // 다음으로 버튼
    let nextButton: UIButton = UIButton().then {
        $0.setTitle("다음으로", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(didNextButtonTapped), for: .touchDown)
    }
    
    let bottomLineView: UIView = UIView().then {
        $0.backgroundColor = UIColor(named: "GrayColor")
    }
    
    let bottomLineView2: UIView = UIView().then {
        $0.backgroundColor = UIColor(named: "GrayColor")
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
        view.backgroundColor = .white
        
        hideKeyboard() // 화면 밖 클릭하면 키보드 내려가게 설정
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(phoneNumberTextField)
        self.view.addSubview(verifyTextField)
        self.view.addSubview(nextButton)
        self.view.addSubview(certifyRequestButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(bottomLineView2)
    } // end of setUpLayout

    
    // MARK: Constraints
    
    func setUpConstraint(){
        label1.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.95)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        label2.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.655)
            $0.centerY.equalToSuperview().multipliedBy(0.43)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview().multipliedBy(0.7)
            $0.bottom.equalToSuperview().multipliedBy(0.39)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.64)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview().multipliedBy(0.75)
            $0.bottom.equalToSuperview().multipliedBy(0.32)
        }

        verifyTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview().multipliedBy(0.9)
            $0.bottom.equalToSuperview().multipliedBy(0.46)
        }
        
        bottomLineView2.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview().multipliedBy(0.99)
            $0.bottom.equalToSuperview().multipliedBy(0.39)
        }
        
        certifyRequestButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.23)
            $0.height.equalToSuperview().multipliedBy(0.055)
            $0.right.equalToSuperview().multipliedBy(0.95)
            $0.bottom.equalToSuperview().multipliedBy(0.32)
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    } // end of setUpConstraint
    
    
    // MARK: Functions
    
    @objc func didNextButtonTapped() {
        navigationController?.pushViewController(Onboarding03VC(), animated: true)
    } // end of didNextButtonTapped()
} // end of OnBoarding02VC


struct Onboarding02VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding02VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

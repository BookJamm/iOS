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
    
    let label1: UILabel = UILabel().then{
        $0.text = "회원가입을 위한 전화번호를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    let label2: UILabel = UILabel().then {
        $0.text = "원활한 BOOKJAM 서비스 이용을 위해\n최초 1회 인증이 필요합니다."
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    let phoneNumberTextField: UITextField = UITextField().then{   //전화번호 입력 텍스트 필드
        
        $0.placeholder = "000 0000 0000"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.textColor = UIColor.white
        
    }
    
    let verifyTextField: UITextField = UITextField().then{  //인증번호 입력 텍스트 필드
        $0.placeholder = "인증번호 입력"
    }
    
    let certifyRequestButton: UIButton = UIButton().then {    //인증요청 버튼
        $0.setTitle("인증 요청", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        
    }
    let nextButton: UIButton = UIButton().then{ //다음으로 버튼
        $0.setTitle("다음으로", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)

    }
    
    let bottomLineView: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    let bottomLineView2: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpConstraint()
        
    }
    
    func setUpLayout() {
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(phoneNumberTextField)
        self.view.addSubview(verifyTextField)
        self.view.addSubview(nextButton)
        self.view.addSubview(certifyRequestButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(bottomLineView2)
    }//end of setUpLayout

    func setUpConstraint(){
        label1.snp.makeConstraints{ make in
            
            make.centerY.equalToSuperview().multipliedBy(0.2)
//            make.centerX.equalToSuperview().multipliedBy(0.78)
            make.leading.equalToSuperview().offset(10)
            
//            make.top.equalToSuperview().offset(50)
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.height.equalTo(30)
//            make.bottom.equalTo(label2.snp.top).offset(-15)
        }
        
        label2.snp.makeConstraints{ make in
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
//            make.bottom.equalTo(phoneNumberTextField).offset(-100)
        }
        
        phoneNumberTextField.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalTo(certifyRequestButton.snp.leading).offset(-10)
            make.bottom.equalTo(verifyTextField).offset(-50)
            
        }
        bottomLineView.snp.makeConstraints{
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(-3)
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            
        }

        verifyTextField.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTextField).offset(50)
            make.leading.equalToSuperview().offset(10)

            make.trailing.equalToSuperview().offset(-10)
            
        }
        bottomLineView2.snp.makeConstraints{
            $0.top.equalTo(verifyTextField.snp.bottom).offset(-3)
//            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.trailing.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            
        }
        
        certifyRequestButton.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTextField.snp.top)
//            make.leading.equalTo(phoneNumberTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.size.width.equalTo(80)
//            make.height.equalTo(50)
            make.height.equalToSuperview().multipliedBy(0.06)
            make.centerY.equalTo(phoneNumberTextField)
            make.bottom.equalToSuperview().multipliedBy(0.5)
            
            
        }
        
        nextButton.snp.makeConstraints{
            
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.97)
        }
        
    }//end of setUpConstraint
    
}   //end of OnBoarding02VC


struct Onboarding02VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding02VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

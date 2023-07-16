//
//  Onboarding03VC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/15.
//

import SwiftUI
import UIKit

class Onboarding03VC: UIViewController {

    let registerLabel: UILabel = UILabel().then{
        $0.text = "회원 가입"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    let idLabel: UILabel = UILabel().then{
        $0.text = "아이디 입력"
        $0.font = UIFont.systemFont(ofSize: 20)
        
    }
    
    let passWordLabel: UILabel = UILabel().then{
        $0.text = "비밀번호 입력"
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    let emailTextField: UITextField = UITextField().then{
        $0.placeholder = "email@email.com"
    }
    
    let passWordTextField: UITextField = UITextField().then{
        $0.placeholder = "비밀번호 입력"
    }

    let passWordConfirmTextField: UITextField = UITextField().then{
        $0.placeholder = "비밀번호 확인"
    }
    
    let idDuplicateLabel: UILabel = UILabel().then{
        $0.isHidden = false
        $0.text = "중복된 아이디입니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let passWordConditionLabel: UILabel = UILabel().then{
        $0.text = "비밀번호 조건"
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let passWordAccrodLabel: UILabel = UILabel().then{
        $0.text = "비밀번호가 일치합니다."
        $0.textColor = .green
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let duplicateRequestButton: UIButton = UIButton().then {    //중복확인 버튼
        $0.setTitle("중복 확인", for: .normal)
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
    let bottomLineView3: UIView = UIView().then {
            $0.backgroundColor = UIColor(named: "GrayColor")
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpConstraint()

        // Do any additional setup after loading the view.
    }
    
    func setUpLayout(){
        self.view.addSubview(registerLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(passWordLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passWordTextField)
        self.view.addSubview(passWordConfirmTextField)
        self.view.addSubview(idDuplicateLabel)
        self.view.addSubview(passWordConditionLabel)
        self.view.addSubview(passWordAccrodLabel)
        self.view.addSubview(duplicateRequestButton)
        self.view.addSubview(nextButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(bottomLineView2)
        self.view.addSubview(bottomLineView3)
        
    }

    func setUpConstraint(){
        registerLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(0.2)
            $0.leading.equalToSuperview().offset(10)
        }
        idLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(0.45)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            
        }
        emailTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerY.equalToSuperview().multipliedBy(0.58)
            
            
        }
        
        bottomLineView.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(-18)
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.0011)
        }
        
        duplicateRequestButton.snp.makeConstraints{
            $0.leading.equalTo(emailTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.size.width.equalTo(80)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerY.equalTo(emailTextField)

        }
        idDuplicateLabel.snp.makeConstraints{
            $0.top.equalTo(bottomLineView).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        passWordLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(1)
            $0.leading.equalToSuperview().offset(10)
        }
        passWordTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview().multipliedBy(1.15)
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
            
        }
        bottomLineView2.snp.makeConstraints{
            $0.top.equalTo(passWordTextField.snp.bottom).offset(-18)
            $0.trailing.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.0011)
        }
        passWordConditionLabel.snp.makeConstraints{
            $0.top.equalTo(bottomLineView2).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        passWordConfirmTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview().multipliedBy(1.4)
            $0.width.equalToSuperview().multipliedBy(0.73)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        bottomLineView3.snp.makeConstraints{
            $0.top.equalTo(passWordConfirmTextField.snp.bottom).offset(-18)
            $0.trailing.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.0011)
        }
        passWordAccrodLabel.snp.makeConstraints{
            $0.top.equalTo(bottomLineView3).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        nextButton.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.97)
        }
        
    }//end of setUpConstraint
    
    
}

struct Onboarding03VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding03VC().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}

//
//  Onboard04ViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboarding04VC: UIViewController {
    
    // MARK: Variables
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "프로필과 닉네임을 설정해주세요."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.sizeToFit()
    }
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "BasicProfile")
    }
    
    let bottomLineView: UIView = UIView().then {
        $0.backgroundColor = UIColor(named: "GrayColor")
    }
    
    let nicknameTextField: UITextField = UITextField().then {
        $0.placeholder = "책먹는 두루미"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    let decisionButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.setTitle("결정하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(informationLabel)
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(bottomLineView)
        view.addSubview(decisionButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        informationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview().multipliedBy(0.78)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.93)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        decisionButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.97)
        }
    }
    
}

struct Onboarding04VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding04VC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

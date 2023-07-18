//
//  Onboarding05VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

import SwiftUI
import UIKit

class Onboarding05VC: UIViewController {
    
    // MARK: Variables
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "BOOKJAM을 함께 즐길 친구를\n함께 찾아봐요!"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.sizeToFit()
    }
    
    let searchIDLabel: UILabel = UILabel().then {
        $0.textColor = UIColor(hexCode: "6F6F6F")
        $0.textAlignment = .left
        $0.text = "아이디로 검색하기"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.sizeToFit()
    }
    
    let searchImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = UIColor(named: "MainColor")
    }
    
    let emailTextField: UITextField = UITextField().then {
        $0.placeholder = "bookjam@email.com"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    let bottomLineView: UIView = UIView().then {
        $0.backgroundColor = UIColor(named: "GrayColor")
    }
    
    let recommendFriendLabel: UILabel = UILabel()
    let friendsStackView: UIStackView = UIStackView()
    
    let finishButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.setTitle("완료하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(didFinishButtonTapped), for: .touchUpInside)
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
        view.addSubview(informationLabel)
        view.addSubview(searchIDLabel)
        view.addSubview(emailTextField)
        view.addSubview(searchImageView)
        view.addSubview(bottomLineView)
        view.addSubview(recommendFriendLabel)
        view.addSubview(friendsStackView)
        view.addSubview(finishButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.78)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        searchIDLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.47)
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        finishButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(1.78)
            $0.centerY.equalToSuperview().multipliedBy(0.65)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.55)
            $0.centerY.equalToSuperview().multipliedBy(0.65)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.72)
        }
    }
    
    // MARK: Functions
    
    @objc func didFinishButtonTapped() {
        let onboarding06VC = Onboarding06VC()
        onboarding06VC.modalPresentationStyle = .fullScreen
        
        self.present(onboarding06VC, animated: true)
    } // end of didFinishButtonTapped()
}

struct Onboarding05VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding05VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

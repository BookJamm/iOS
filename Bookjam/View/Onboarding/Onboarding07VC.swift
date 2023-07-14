//
//  Onboarding07VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/15.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboarding07VC: UIViewController {
    
    // MARK: Variables
    
    let leftBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "A5A5A5")
        $0.layer.cornerRadius = 2
    }
    
    let centerBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
    }
    
    let rightBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
    }
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "색다른 경험, 색다른 공간에서\n책과 함께 힐링하고 싶을 때"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 2
        $0.sizeToFit()
    }
    
    let characterImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "Character2")
        $0.contentMode = .scaleAspectFit
    }
    
    let skipButton: UIButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("건너뛰기", for: .normal)
        $0.titleLabel?.textColor = UIColor(hexCode: "A5A5A5")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    let nextButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.setTitle("다음으로", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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
        view.addSubview(leftBarView)
        view.addSubview(centerBarView)
        view.addSubview(rightBarView)
        view.addSubview(informationLabel)
        view.addSubview(characterImageView)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        leftBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.28)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview().multipliedBy(0.4)
            $0.top.equalToSuperview().multipliedBy(0.9)
        }
        
        centerBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.28)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().multipliedBy(0.9)
        }
        
        rightBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.28)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview().multipliedBy(1.6)
            $0.top.equalToSuperview().multipliedBy(0.9)
        }
        
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.7)
            $0.centerY.equalToSuperview().multipliedBy(0.2)
        }
        
        characterImageView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.97)
        }
    }
    
}

struct Onboarding07VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding07VC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

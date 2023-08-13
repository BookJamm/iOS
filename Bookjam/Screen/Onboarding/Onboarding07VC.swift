//
//  Onboarding07VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/15.
//

// MARK: - 앱 미리보기 첫번째 화면

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
        $0.layer.cornerRadius = 2
    }
    
    let rightBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
        $0.layer.cornerRadius = 2
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
    
    let nextButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("메인으로", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.addTarget(self, action: #selector(didNextButtonTapped), for: .touchUpInside)
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
        
        /// 왼쪽으로 슬라이드하면 두번째 캐러셀 화면으로 전환
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.didToLeftSwiped(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(leftBarView)
        view.addSubview(centerBarView)
        view.addSubview(rightBarView)
        view.addSubview(informationLabel)
        view.addSubview(characterImageView)
        view.addSubview(nextButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        leftBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.01)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview().multipliedBy(0.93)
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        
        centerBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.01)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        
        rightBarView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.01)
            $0.height.equalToSuperview().multipliedBy(0.0045)
            $0.centerX.equalToSuperview().multipliedBy(1.07)
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.7)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
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
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    }
    
    
    // MARK: Functions
    
    /// 메인으로 버튼 누르면 온보딩 페이지로 이동
    @objc func didNextButtonTapped() {
        let Onboarding = Onboarding01VC()
        Onboarding.modalPresentationStyle = .fullScreen
        Onboarding.modalTransitionStyle = .coverVertical
        
        self.present(Onboarding, animated: true, completion: nil)
    } // end of didNextButtonTapped()
    
    /// 왼쪽으로 슬라이드하면 두번째 캐러셀 화면으로 전환
    @objc func didToLeftSwiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let onboarding08VC = Onboarding08VC()
                onboarding08VC.modalPresentationStyle = .fullScreen
                onboarding08VC.modalTransitionStyle = .crossDissolve
                
                self.present(onboarding08VC, animated: true)
            default: break
            }
        }
    } // end of didToLeftSwiped()
}

struct Onboarding07VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding07VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

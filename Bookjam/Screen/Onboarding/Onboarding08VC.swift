//
//  Onboarding08VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/15.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboarding08VC: UIViewController {

    // MARK: Variables
    
    let leftBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
        $0.layer.cornerRadius = 2
    }
    
    let centerBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "A5A5A5")
        $0.layer.cornerRadius = 2
    }
    
    let rightBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
        $0.layer.cornerRadius = 2
    }
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "친구들과 함께 다양한 독서 경험,\n특별한 경험을 공유하고 싶을 때"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 2
        $0.sizeToFit()
    }
    
    let characterImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "Character3")
        $0.contentMode = .scaleAspectFit
    }
    
    // TODO: 건너뛰기 버튼 누르면 메인으로 넘어가게 구현 필요
    
    let skipButton: UIButton = UIButton().then {
        $0.setTitle("건너뛰기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "A5A5A5"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    let nextButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("메인으로", for: .normal)
        $0.titleLabel?.textColor = .white
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
        
        // 오른쪽으로 View 슬라이드하면 온보딩 07로 이동
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.didToRightSwiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        // 왼쪽으로 View 슬라이드하면 온보딩 09로 이동
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
        view.addSubview(skipButton)
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
            $0.centerX.equalToSuperview().multipliedBy(0.75)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        characterImageView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.03)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.86)
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    }

    
    // MARK: Functions
    
    @objc func didNextButtonTapped() {
        let onboarding09VC = Onboarding09VC()
        onboarding09VC.modalPresentationStyle = .fullScreen
        onboarding09VC.modalTransitionStyle = .crossDissolve
        
        self.present(onboarding09VC, animated: true)
    } // end of didNextButtonTapped()
    
    
    @objc func didToRightSwiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                let onboarding07VC = Onboarding07VC()
                onboarding07VC.modalPresentationStyle = .fullScreen
                onboarding07VC.modalTransitionStyle = .crossDissolve
                
                self.present(onboarding07VC, animated: true)
            default: break
            }
        }
    } // end of didToRightSwiped()
    
    
    @objc func didToLeftSwiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let onboarding09VC = Onboarding09VC()
                onboarding09VC.modalPresentationStyle = .fullScreen
                onboarding09VC.modalTransitionStyle = .crossDissolve
                
                self.present(onboarding09VC, animated: true)
            default: break
            }
        }
    } // end of didToLeftSwiped()
}

struct Onboarding08VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding08VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}


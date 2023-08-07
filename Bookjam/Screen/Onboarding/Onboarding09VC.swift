//
//  Onboarding09VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/15.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboarding09VC: UIViewController {

    // MARK: Variables
    
    let leftBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
        $0.layer.cornerRadius = 2
    }
    
    let centerBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "EAEAEA")
        $0.layer.cornerRadius = 2
    }
    
    let rightBarView: UIView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "A5A5A5")
        $0.layer.cornerRadius = 2
    }
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "내 주변의 다양한 독서 공간을\n검색하고, 기록해보세요!"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 2
        $0.sizeToFit()
    }
    
    let characterImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "Character4")
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
        
        // 오른쪽으로 View 슬라이드하면 온보딩 08로 이동
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.didToRightSwiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
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
            $0.centerX.equalToSuperview().multipliedBy(0.72)
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
        let mainPage = MainTabBarController()
        mainPage.modalPresentationStyle = .fullScreen
        mainPage.modalTransitionStyle = .coverVertical
        
        self.present(mainPage, animated: true, completion: nil)
    } // end of didNextButtonTapped()
    
    
    @objc func didToRightSwiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                let onboarding08VC = Onboarding08VC()
                onboarding08VC.modalPresentationStyle = .fullScreen
                onboarding08VC.modalTransitionStyle = .crossDissolve
                
                self.present(onboarding08VC, animated: true)
            default: break
            }
        }
    } // end of didToRightSwiped()
}

struct Onboarding09VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding09VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

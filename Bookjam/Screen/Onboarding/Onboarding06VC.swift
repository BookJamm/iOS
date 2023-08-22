//
//  Onboarding06VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/15.
//

// MARK: - 가입 완료 화면

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboarding06VC: UIViewController {

    // MARK: Variables
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "BOOKJAM에\n가입하신 것을 축하합니다 🎉"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 2
        $0.sizeToFit()
    }
    
    let characterImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "Character1")
        $0.contentMode = .scaleAspectFit
    }
    
    let startButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("BOOKJAM 시작하기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.addTarget(self, action: #selector(didStartButtonTapped), for: .touchUpInside)
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
        view.addSubview(characterImageView)
        view.addSubview(startButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.75)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        characterImageView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    }
    
    // MARK: Functions
    
    // 북잼 시작하기 버튼 누르면 케러셀 화면으로 넘어가도록 구현
    @objc func didStartButtonTapped() {
        let onboarding07VC = Onboarding07VC()
        onboarding07VC.modalPresentationStyle = .fullScreen
        onboarding07VC.modalTransitionStyle = .crossDissolve
        
        self.present(onboarding07VC, animated: true)
    } // end of didStartButtonTapped()
}

//struct Onboarding06VC_Preview: PreviewProvider {
//    static var previews: some View {
//        Onboarding06VC().toPreview()
//            .edgesIgnoringSafeArea(.all)
//    }
//}

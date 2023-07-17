//
//  Onboard04ViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

import PhotosUI
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
    
    let profileButton: UIButton = UIButton().then {
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.clipsToBounds = true
        $0.setImage(UIImage(named: "BasicProfile"), for: .normal)
        $0.addTarget(self, action: #selector(didProfileButtonTapped), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(didDecisionButtonTapped), for: .touchUpInside)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpView()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        hideKeyboard() // 화면 밖 클릭하면 키보드 내려가게 설정
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(informationLabel)
        view.addSubview(profileButton)
        view.addSubview(nicknameTextField)
        view.addSubview(bottomLineView)
        view.addSubview(decisionButton)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.78)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        profileButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.65)
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
            $0.bottom.equalToSuperview().multipliedBy(0.94)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didProfileButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        print("11")
        var configuration = PHPickerConfiguration()
        
        configuration.selectionLimit = 1 // 최대로 선택할 사진 수 1로 설정
        configuration.filter = .images // 선택할 수 있는 미디어 종류 사진으로 제한
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
    } // end of didProfileImageViewTapped()
    
    
    @objc func didDecisionButtonTapped() {
        navigationController?.pushViewController(Onboarding05VC(), animated: true)
    } // end of didDecisionButtonTapped()
}


// MARK: Preview

struct Onboarding04VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding04VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}


// MARK: Extension

extension Onboarding04VC : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        
        picker.dismiss(animated: true, completion: nil)
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let selectedImage = image as? UIImage else { return }
                    
                    self.profileButton.setImage(selectedImage, for: .normal)
                } // end of DispatchQueue
            } // end of itemProvider.loadObject()
        } // end of itemProvider.canLoadObject()
    } // end of picker()
} // end of extension

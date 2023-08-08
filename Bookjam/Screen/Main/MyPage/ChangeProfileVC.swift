//
//  ChangeProfileVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/08.
//

// MARK: - 유저 페이지에서 프로필/닉네임 변경 버튼 누르면 전환되는 화면

import PhotosUI
import SwiftUI
import UIKit

import SnapKit
import Then

class ChangeProfileVC: UIViewController {

    // MARK: Variables
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "프로필과 닉네임을 설정해주세요."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.sizeToFit()
    }
    
    let profileButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "BasicProfile"), for: .normal)
        $0.addTarget(self, action: #selector(didProfileButtonTapped), for: .touchUpInside)
    }
    
    let plusButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "profilePlusButton"), for: .normal)
        $0.addTarget(self, action: #selector(didProfileButtonTapped), for: .touchUpInside)
    }
    
    let bottomLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    let nicknameTextField: UITextField = UITextField().then {
        $0.placeholder = "책먹는 두루미"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    let decisionButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("결정하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(didDecisionButtonTapped), for: .touchUpInside)
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
        
        // 화면 밖 클릭하면 키보드 내려가게 설정
        hideKeyboard()
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            informationLabel,
            profileButton,
            plusButton,
            nicknameTextField,
            bottomLineView,
            decisionButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
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
        
        plusButton.snp.makeConstraints {
            $0.bottom.equalTo(profileButton.snp.bottom)
            $0.trailing.equalTo(profileButton.snp.trailing)
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
    
    // 결정하기 버튼 누르면 다음으로 화면 넘어가게 하는 함수
    // decisionButton에 addTarget으로 연결됨
    @objc func didDecisionButtonTapped() {
        self.dismiss(animated: true)
    } // end of didDecisionButtonTapped()
    
}

// MARK: Extension

// 프로필 설정 중 갤러리에서 이미지 가져오게 하는 기능 구현을 위한 extension
extension ChangeProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 프로필 버튼 누르면 imagePicker present 되도록 구현
    // profileButton에 addTarget으로 연결됨
    @objc func didProfileButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    } // end of didProfileImageViewTapped()
    
    // present된 imagePicker에서 이미지를 선택하면 그 이미지가 profileButton의 이미지로 설정되도록 구현
    // 이후 imagePicker를 dismiss함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileButton.setImage(image.circularImage(), for: .normal)
        }
        dismiss(animated: true , completion: nil)
    }
}


struct ChangeProfileVC_Preview: PreviewProvider {
    static var previews: some View {
        ChangeProfileVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

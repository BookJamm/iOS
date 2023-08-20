//
//  BookStoreReviewDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/10.
//

import PhotosUI
import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreReviewDetailVC: UIViewController {

    // MARK: Variables
    
    /// 디테일 페이지에서 넘어올 placeID 받을 변수 구현
    var placeID: Int = 1
    
    var selectedButton = -1
    
    var selectLabel: UILabel = UILabel().then {
        $0.text = "인증 방법을 선택해주세요."
        $0.font = title06
    }
    
    var shootButton: UIButton = UIButton().then {
        $0.setTitle("영수증 촬영", for: .normal)
        $0.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.tintColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = main03
        
        // 버튼 이미지 위치 커스텀을 위한 config 변수 선언
        var configuration = UIButton.Configuration.plain()
        // 버튼 이미지 위로 오도록 config 속성 부여
        configuration.imagePadding = 15
        configuration.imagePlacement = .top
        
        $0.configuration = configuration
        
        $0.addTarget(self, action: #selector(didShootButtonTapped), for: .touchUpInside)
    }
    
    var albumButton: UIButton = UIButton().then {
        $0.setTitle("앨범에서 선택", for: .normal)
        $0.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.tintColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = main03
        
        // 버튼 이미지 위치 커스텀을 위한 config 변수 선언
        var configuration = UIButton.Configuration.plain()
        // 버튼 이미지 위로 오도록 config 속성 부여
        configuration.imagePadding = 15
        configuration.imagePlacement = .top
        
        $0.configuration = configuration
        
        $0.addTarget(self, action: #selector(didAlbumButtonTapped), for: .touchUpInside)
    }
    
    var withoutAuthButton: UIButton = UIButton().then {
        $0.setTitle("인증 없이 작성", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = main03?.cgColor
    }
    
    var authImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    
    var visitDateButton: UIButton = UIButton().then {
        $0.setTitle("방문 일정 작성", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.backgroundColor = gray04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didVisitDateButtonTapped), for: .touchUpInside)
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
        [
            selectLabel,
            shootButton,
            albumButton,
            withoutAuthButton,
            authImageView,
            visitDateButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        selectLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        shootButton.snp.makeConstraints {
            $0.top.equalTo(selectLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.centerX).offset(-10)
            $0.height.equalTo(100)
        }
        
        albumButton.snp.makeConstraints {
            $0.top.equalTo(selectLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view.snp.centerX).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        withoutAuthButton.snp.makeConstraints {
            $0.top.equalTo(shootButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
        }
        
        authImageView.snp.makeConstraints {
            $0.top.equalTo(albumButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(400)
        }
        
        visitDateButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Function
    
    @objc func didVisitDateButtonTapped() {
        let dateVC = BookStoreChoiceDateVC()
        dateVC.placeID = self.placeID
        
        navigationController?.pushViewController(dateVC, animated: true)
    }
}

// MARK: Extension

// 촬영 및 갤러리에서 이미지 가져오게 하는 기능 구현을 위한 extension
extension BookStoreReviewDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 영수증 촬영 버튼 누르면 인증 사진 촬영하도록 구현
    @objc func didShootButtonTapped() {
        // 버튼 비활성화를 위한 인덱스 부여
        selectedButton = 0
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    // 앨범에서 선택 버튼 누르면 앨범 띄우도록 구현
    @objc func didAlbumButtonTapped() {
        // 버튼 비활성화를 위한 인덱스 부여
        selectedButton = 1
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    } // end of didProfileImageViewTapped()
    
    // present된 imagePicker에서 이미지를 선택하면 그 이미지가 profileButton의 이미지로 설정되도록 구현
    // 이후 imagePicker를 dismiss함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 선택된 이미지 화면에 표시되도록 구현
            authImageView.image = image
            authImageView.isHidden = false
            
            if selectedButton == 0 {
                // 영수증 촬영 버튼 선택 못하도록 처리
                shootButton.backgroundColor = gray04
                shootButton.isEnabled = false
            }
            else if selectedButton == 1 {
                // 앨범에서 선택 버튼 선택 못하도록 처리
                albumButton.backgroundColor = gray04
                albumButton.isEnabled = false
            }
            
            // 인증 없이 작성 버튼 숨김 처리
            withoutAuthButton.isHidden = true
            
            // 방문 일정 작성 버튼 활성화하고 타이틀 변환 처리
            visitDateButton.setTitle("다음으로", for: .normal)
            visitDateButton.backgroundColor = main03
            visitDateButton.isEnabled = true
        }
        dismiss(animated: true , completion: nil)
    }
}


struct BookStoreReviewDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreReviewDetailVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

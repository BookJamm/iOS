//
//  BookStoreReviewDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/10.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreReviewDetailVC: UIViewController {

    // MARK: Variables
    
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
    }
    
    var withoutAuthButton: UIButton = UIButton().then {
        $0.setTitle("인증 없이 작성", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = main03?.cgColor
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
            withoutAuthButton
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
    }
    
}

struct BookStoreReviewDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreReviewDetailVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

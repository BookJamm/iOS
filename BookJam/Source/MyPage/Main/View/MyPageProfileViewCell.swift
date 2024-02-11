//
//  MyPageProfileViewCell.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import UIKit
import SnapKit
import Then

class MyPageProfileViewCell: UICollectionViewCell {
    
    static let id = "MyPageProfileViewCell"
    
//    var viewModel: MyPageProfileViewCellModel?
    
    /// 프로필 이미지 뷰
    private lazy var profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage.defaultProfile
    }
    
    /// 프로필 텍스트 라벨
    private lazy var profileTextLabel: UILabel = UILabel().then {
        $0.text = "default"
        $0.font = paragraph02
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .white
    }
    
    private func setUpLayout() {
        [
            profileImageView,
            profileTextLabel
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        profileTextLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
    
    private func setUpBinding() {
        
    }
}

@available(iOS 17.0,*)
#Preview {
    MyPageProfileViewCell()
}


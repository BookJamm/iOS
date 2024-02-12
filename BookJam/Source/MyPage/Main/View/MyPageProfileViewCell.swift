//
//  MyPageProfileViewCell.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class MyPageProfileViewCell: UICollectionViewCell {
    
    static let id = "MyPageProfileViewCell"
    
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
    
    /// 임시 테스트용 Configure입니다. -> API 완성후 보완 필요
    /// 여기에서 URL을 가지고 Request 하는게 맞는지, ViewModel에서 처리후 VC를 통해 UIImage를 주입받아야 하는지는 추후 고려해야 합니다.
    func configure(imageURL: String?, name: String) {
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url)
        }
        profileTextLabel.text = name
    }
}

@available(iOS 17.0,*)
#Preview {
    MyPageProfileViewCell()
}


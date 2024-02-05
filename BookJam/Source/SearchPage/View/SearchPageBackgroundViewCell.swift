//
//  SearchPageBackgroundView.swift
//  BookJam
//
//  Created by 박민서 on 2/5/24.
//

import UIKit
import SnapKit
import Then

class SearchPageBackgroundViewCell: UICollectionViewCell {
    
    static let id = "SearchPageBackgroundViewCell"
    
    var backgroundContentType: SearchPageBackgroundType = .start
    
    let imageView: UIImageView = UIImageView()
    
    let title:UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = gray10
    }
    
    let subTitle:UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray07
        $0.numberOfLines = 2
        $0.textAlignment = .center
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
        imageView.image = backgroundContentType.image
        title.text = backgroundContentType.title
        subTitle.text = backgroundContentType.subTitle
    }
    
    private func setUpLayout() {
        [
            imageView,
            title,
            subTitle
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(210)
            $0.leading.equalTo(70)
            $0.trailing.equalTo(-70)
            $0.top.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalTo(imageView)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.centerX.equalTo(title)
        }
    }
    
    func configure(type: SearchPageBackgroundType) {
        self.backgroundContentType = type
    }
}

@available(iOS 17.0,*)
#Preview {
    SearchPageBackgroundViewCell()
}

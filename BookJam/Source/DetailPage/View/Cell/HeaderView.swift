//
//  HeaderView.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = "Header입니다"
    }
    private let moreButton: UIButton = UIButton().then{
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(main01, for: .normal)
        $0.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(moreButton)
        
        titleLabel.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        moreButton.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  BookListCollectionViewCell.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

// MARK: - 홈 탭에서 책 목록에 표시될 책 정보 셀

import UIKit
import SwiftUI

import SnapKit
import Then


class BookListCollectionViewCell: UICollectionViewCell {
    // MARK: Variables
    
    // CollectionView가 여러 개라 extension 분기 나누는 거 고려해서 cell id 전부 homeViewCell로 통일
    static var id = "homeListCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "emptyBook")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
        $0.text = "등록된 책이 없습니다."
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = ""
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = ""
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
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookImageView,
            titleLabel,
            authorLabel,
            publisherLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(200)
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(25)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.top)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
    }
}

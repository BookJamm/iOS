//
//  BookStoreNewsCollectionViewCell.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit

class BookNewsCollectionViewCell: UICollectionViewCell {
    
    static let cellID =  "HomeNewsCell"
    
    var profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
    }
    
    var newsView: UIView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = gray02
    }
    
    var newsLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "뉴스 제목"
        $0.sizeToFit()
    }
    
    var newsContent: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "뉴스내용뉴진스내용뉴스내용뉴진스내용뉴스내용뉴진스내용뉴스내용뉴진스내용뉴스내용뉴진스내용뉴스내용뉴진스내용"
        $0.numberOfLines = 20
        $0.sizeToFit()
    }
    
    var newsDate: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "yyyy. mm. dd"
        $0.sizeToFit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            newsView
        ].forEach { self.addSubview($0) }
        
        [
            newsLabel,
            newsContent,
            newsDate
        ].forEach { newsView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(60)
        }
        
        newsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(newsView.snp.top).offset(16)
            $0.leading.equalTo(newsView.snp.leading).offset(16)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        newsContent.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom).offset(6)
            $0.leading.equalTo(newsLabel.snp.leading)
            $0.trailing.equalTo(newsView.snp.trailing).offset(-16)
        }
        
        newsDate.snp.makeConstraints {
            $0.top.equalTo(newsContent.snp.bottom).offset(6)
            $0.leading.equalTo(newsLabel.snp.leading)
            $0.bottom.equalTo(newsView.snp.bottom).offset(-20)
        }
    }
}

//
//  MainDetailNewsTableViewController.swift
//  BookJam
//
//  Created by 장준모 on 11/30/23.
//

import UIKit
import RxSwift

class MainDetailNewsTableViewCell: UITableViewCell {

    static let id =  "HomeNewsTabCell"
    
    var disposeBag = DisposeBag()
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            disposeBag = DisposeBag() // 셀이 재사용될 때마다 새 DisposeBag을 생성합니다.
        }

    
    var profileImageView: UIImageView = UIImageView().then {
//        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
        $0.image = UIImage(named: "squareDefaultImage")
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20))
    }
    
    // MARK: View
    
    func setUpView() {
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
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(60)
        }
        
        newsView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(newsView.snp.top).offset(12.5)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        newsContent.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom).offset(6.5)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        newsDate.snp.makeConstraints {
            $0.top.equalTo(newsContent.snp.bottom).offset(6.5)
            $0.leading.equalTo(newsLabel.snp.leading)
            $0.bottom.equalTo(newsView.snp.bottom).inset(12.5)
        }
    }
    
    public func configure(title: String, content: String, date: String) {
        newsLabel.text = title
        newsContent.text = content
        newsDate.text = date
    }
}

#if DEBUG
import SwiftUI

@available(iOS 16.0, *)
struct MainDetailNewsTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailNewsTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

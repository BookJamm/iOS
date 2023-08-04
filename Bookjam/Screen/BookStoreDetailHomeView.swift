//
//  BookStoreDetailHomeView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreDetailHomeView: UIView {

    // MARK: Variables
    
    var bookstoreName = String()
    var news = News(storePhoto: "", title: "", content: "", date: "", photo: "")
    var books = [Book]()
    
    var contentView: UIView = UIView().then {
        $0.backgroundColor = gray02
    }
    
    var newsView: UIView = UIView().then {
        $0.backgroundColor = .white
    }

    var newsLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
    }

    var newsMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didNewsTapped), for: .touchUpInside)
    }
    
    var newsPreview: UIView = UIView().then {
        $0.backgroundColor = main05
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    var newsPhoto: UIImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    var newsTitle: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
    }
    
    var newsContent: UILabel = UILabel().then {
        $0.font = paragraph06
        $0.textColor = .black
    }
    
    var newsDate: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = .black
    }
    
    var bookListView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookListLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "책 목록"
        $0.sizeToFit()
    }
    
    var bookListMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didBookListTapped), for: .touchUpInside)
    }
    
    var bookActivityView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookActivityLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "독서 활동 참여 목록"
    }
    
    var bookActivityCountLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = main03
        $0.text = "0"
    }
    
    var bookActivityMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didBookActivityTapped), for: .touchUpInside)
    }
    
    var reviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var reviewLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "리뷰"
    }
    
    var reviewMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didReviewTapped), for: .touchUpInside)
    }

    
    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        // TODO: 데이터 받아올 부분
        bookstoreName = "bookstore_name"
        news.title = "연휴 휴무 안내"
        news.photo = "squareDefaultImage"
        news.content = "이번 연휴 기간동안 휴무입니다 ;)\n좋은 연휴 보내세요"
        news.date = "2023. 05. 28"
        
        // 소식 Section 업데이트
        newsLabel.text = "\(bookstoreName)의 소식"
        newsTitle.text = news.title
        newsContent.text = news.content
        newsDate.text = news.date
        newsPhoto.image = UIImage(named: "squareDefaultImage")
        
        // newsContent 글자 수 일정 이상이면 2줄로 표시
        if news.content.count >= 18 { newsContent.numberOfLines = 2 }
        
        // 책 목록 Section 업데이트
        books.append(Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", photo: "tempBookImage"))
        books.append(Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", photo: "tempBookImage"))
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            newsView,
            bookListView,
            bookActivityView,
            reviewView
        ].forEach { self.addSubview($0) }
        
        [
            newsLabel,
            newsMoreButton,
            newsPreview
        ].forEach { newsView.addSubview($0) }
        
        [
            newsTitle,
            newsPhoto,
            newsContent,
            newsDate
        ].forEach { newsPreview.addSubview($0) }
        
        [
            bookListLabel,
            bookListMoreButton,
        ].forEach { bookListView.addSubview($0) }
        
        [
            bookActivityLabel,
            bookActivityCountLabel,
            bookActivityMoreButton
        ].forEach { bookActivityView.addSubview($0)}
        
        [
            reviewLabel,
            reviewMoreButton
        ].forEach { reviewView.addSubview($0)}
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        newsView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(230)
        }

        newsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        newsMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(newsLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        newsPreview.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(120)
        }
        
        newsPhoto.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(newsPreview.snp.height)
        }
        
        newsTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        newsContent.snp.makeConstraints {
            $0.top.equalTo(newsTitle.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        newsDate.snp.makeConstraints {
            $0.top.equalTo(newsContent.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        bookListView.snp.makeConstraints {
            $0.top.equalTo(newsView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        bookListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookListMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(bookListLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        bookActivityView.snp.makeConstraints {
            $0.top.equalTo(bookListView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        bookActivityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookActivityCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalTo(bookActivityLabel.snp.trailing).offset(5)
        }
        
        bookActivityMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(bookActivityLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(bookActivityView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
            $0.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        reviewMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(reviewLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didNewsTapped() {
        // navigationController?.pushViewController(BookStoreDetailNewsView(), animated: true)
    }
    
    @objc func didBookListTapped() {
        // navigationController?.pushViewController(BookStoreDetailBookTypeView(), animated: true)
    }
    
    @objc func didBookActivityTapped() {
        // navigationController?.pushViewController(BookStoreDetailJoinView(), animated: true)
    }
    
    @objc func didReviewTapped() {
        // navigationController?.pushViewController(BookStoreDetailReviewView(), animated: true)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailHomeView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailHomeView()
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

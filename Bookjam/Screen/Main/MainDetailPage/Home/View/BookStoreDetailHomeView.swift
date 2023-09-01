//
//  BookStoreDetailHomeView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 페이지에 표시되는 홈 탭

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreDetailHomeView: UIView {

    // MARK: Variables
    
    var bookstoreName = String()

    var news: PlaceIdNewsResponseModel? = nil
    
    var books: [PlaceIdBooksResponseModel]? = nil
    
    var reviews: [PlaceIdReviewsResponseModel]? = nil
    
    // 독서 활동 참여 목록에 들어갈 데이터 변수 Activity 배열로 선언
    var activities: [Activities]? = nil
    
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
    
    var bookListCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.cellID)
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
        $0.text = "1"
    }
    
    var bookActivityMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didBookActivityTapped), for: .touchUpInside)
    }
    
    var bookActivityCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookActivityCollectionViewCell.self, forCellWithReuseIdentifier: BookActivityCollectionViewCell.cellID)
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
    
    var reviewTableView: UITableView = UITableView().then {
        $0.register(VisitReviewTableViewCell.self, forCellReuseIdentifier: VisitReviewTableViewCell.cellID)
        // 스크롤 중첩으로 false 처리함
        $0.isScrollEnabled = false
    }

    
    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        
        // 소식 Section 업데이트
        newsLabel.text = "\(bookstoreName)의 소식"
        newsTitle.text = news?.title
        newsContent.text = news?.contents
        newsDate.text = news?.createdAt!.components(separatedBy: "T")[0]
        newsPhoto.image =  UIImage(named: "squareDefaultImage")
        
        if let contents = news?.contents{
            if contents.count >= 18{
                newsContent.numberOfLines = 3
            }
        }
                
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
            bookListCollectionView
        ].forEach { bookListView.addSubview($0) }
        
        [
            bookActivityLabel,
            bookActivityCountLabel,
            bookActivityMoreButton,
            bookActivityCollectionView
        ].forEach { bookActivityView.addSubview($0)}
        
        [
            reviewLabel,
            reviewMoreButton,
            reviewTableView
        ].forEach { reviewView.addSubview($0)}
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        bookListCollectionView.delegate = self
        bookListCollectionView.dataSource = self
        
        bookActivityCollectionView.delegate = self
        bookActivityCollectionView.dataSource = self
        
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
        // 소식 Section
        
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
            $0.height.equalTo(130)
        }
        
        newsPhoto.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(newsPreview.snp.height)
        }
        
        newsTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        newsContent.snp.makeConstraints {
            $0.top.equalTo(newsTitle.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
            $0.trailing.equalTo(newsPreview.snp.trailing).offset(-5)
        }
        
        newsDate.snp.makeConstraints {
            $0.top.equalTo(newsContent.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        // 책 목록 Section
        
        bookListView.snp.makeConstraints {
            $0.top.equalTo(newsView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(370)
        }
        
        bookListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookListMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(bookListLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        bookListCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookListLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        // 독서 활동 참여 목록 Section
        
        bookActivityView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(630)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }

        bookActivityLabel.snp.makeConstraints {
            $0.top.equalTo(bookActivityView.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        bookActivityCountLabel.snp.makeConstraints {
            $0.top.equalTo(bookActivityLabel.snp.top)
            $0.leading.equalTo(bookActivityLabel.snp.trailing).offset(10)
        }

        bookActivityMoreButton.snp.makeConstraints {
            $0.top.equalTo(bookActivityLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-20)
        }

        bookActivityCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookActivityCountLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bookActivityView.snp.bottom).offset(-20)
        }
        
        // 리뷰 Section
        
        reviewView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(1030)
            $0.leading.trailing.equalToSuperview()
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
        
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: Functions
    
    // 소식 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didNewsTapped() {
        // navigationController?.pushViewController(BookStoreDetailNewsView(), animated: true)
    }
    
    // 책 목록 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didBookListTapped() {
        // navigationController?.pushViewController(BookStoreDetailBookTypeView(), animated: true)
    }
    
    // 독서 활동 참여 목록 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didBookActivityTapped() {
        // navigationController?.pushViewController(BookStoreDetailJoinView(), animated: true)
    }
    
    // 리뷰 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didReviewTapped() {
        // navigationController?.pushViewController(BookStoreDetailReviewView(), animated: true)
    }
}

// 책 목록, 독서 활동 참여 목록 밑에 들어갈 CollectionView 구현을 위한 Delegate, DataSource extension
// 가로 스크롤 구현을 위해 FlowLayout extension도 추가함
extension BookStoreDetailHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 책 목록 셀 수 초기화
        if collectionView == self.bookListCollectionView {
            return books?.count ?? 0
        }
        // 독서 활동 참여 목록 셀 수 초기화
        else if collectionView == self.bookActivityCollectionView {
            return activities?.count ?? 0
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // CollectionView가 여러 개라 extension 분기 나누는 거 고려해서 cell id 전부 homeViewCell로 통일
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath)
        
        // 이후 collectionView가 어떤 collectionView냐에 따라 분기 나누어 줌
        // 책 목록 데이터 삽입
        if collectionView == self.bookListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath) as! BookListCollectionViewCell
            
            cell.titleLabel.text = books![indexPath.row].title
            cell.authorLabel.text = books![indexPath.row].author
            cell.publisherLabel.text = books![indexPath.row].publisher
            
            if let imageUrlString = books![indexPath.row].cover {
                if let imageUrl = URL(string: imageUrlString) {
                    
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                cell.bookImageView.image = image
                            }
                        }
                    }
                }
            } else {
                cell.bookImageView.image = UIImage(named: "squareDefaultImage")
            }
            
            return cell
        }
        // 독서 활동 참여 목록 데이터 삽입
        else if collectionView == self.bookActivityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath) as! BookActivityCollectionViewCell
            
            
            self.bookActivityCountLabel.text = String(activities?.count ?? 0)
            
            if let imageUrlString = activities![indexPath.row].imageUrl {
                if let imageUrl = URL(string: imageUrlString) {
                    
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                cell.activityImageView.image = image
                            }
                        }
                    }
                }
            } else {
                cell.activityImageView.image = UIImage(named: "squareDefaultImage")
            }
            
            cell.titleLabel.text = activities![indexPath.row].title
            cell.ratingLabel.text = String(activities![indexPath.row].totalRating!)
            
            return cell
        }
        return cell
    }
    
    // 모든 셀 사이즈는 높이 150으로 통일
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
}

// 리뷰 탭 밑에 들어갈 리뷰 목록 구현을 위한 Delegate, DataSource extension
extension BookStoreDetailHomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
    
    // 리뷰 목록 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "visitReviewCell", for: indexPath) as! VisitReviewTableViewCell
        
        cell.userNameLabel.text = reviews![indexPath.row].author.username
        cell.userVisitDateLabel.text = reviews![indexPath.row].visitedAt?.components(separatedBy: "T")[0]
        cell.commentLabel.text = reviews![indexPath.row].contents
        
        
        let imageArray: [UIImageView] = [cell.firstImage, cell.secondImage, cell.thirdImage, cell.fourthImage]
        
        if let images = reviews![indexPath.row].images {
            for index in 0..<imageArray.count {
                let imageView = imageArray[index]
                
                if index < images.count, let imageUrlString = images[index].url {
                    if let imageUrl = URL(string: imageUrlString) {
                        DispatchQueue.global().async {
                            if let imageData = try? Data(contentsOf: imageUrl),
                               let image = UIImage(data: imageData) {
                                DispatchQueue.main.async {
                                    imageView.image = image
                                }
                            }
                        }
                    } else {
                        imageView.image = UIImage(named: "squareDefaultImage")
                    }
                } else {
                    imageView.image = UIImage(named: "squareDefaultImage")
                }
            }
        }
        return cell
    }
    
    // TODO: 사진 유무 and 리뷰 길이에 따라 높이 수정해야 함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct BookStoreDetailHomeView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = BookStoreDetailHomeView()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
//#endif

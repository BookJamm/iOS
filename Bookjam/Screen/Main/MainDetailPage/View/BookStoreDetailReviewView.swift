//
//  BookStoreDetailReviewView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 페이지 리뷰 탭 구현

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailReviewView: UIView {
    
    // MARK: Variables
    
    // 리뷰 데이터 삽입을 위한 Review 배열 선언
    var reviews: [Review] = [
        Review(userName: "독서 장인", visitDate: "2023 / 08 / 03 방문", comment: "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!", photos: ["ChaekYeonFive", "ChaekYeonSeven", "ChaekYeonEight", "ChaekYeonNine"]),
        Review(userName: "짐깅", visitDate: "2023 / 07 / 24 방문", comment: "조용하고 혼자 앉아서 힐링하기 좋아요! 추천합니다 🙌", photos: ["ChaekYeon", "ChaekYeonThree", "ChaekYeonFour", "ChaekYeonTwo"]),
        Review(userName: "장모", visitDate: "2023 / 07 / 22 방문", comment: "분위기가 정말 좋아요! 친구에게 추천해주고 싶습니다", photos: ["ChaekYeonFive", "ChaekYeonSeven", "ChaekYeonNine", "ChaekYeonFour"]),
        Review(userName: "모아", visitDate: "2023 / 06 / 08 방문", comment: "ㅠㅠ 오늘 휴무인줄 몰랐어요 다음에 또 올게요!", photos: ["ChaekYeonNine", "ChaekYeonEight", "ChaekYeon", "squareDefaultImage"])
    ]
    
    var writeReviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var writeReviewLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "리뷰 작성"
    }
    
    var writeReviewButton: UIButton = UIButton().then {
        $0.setTitle("인증 후 리뷰 작성하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.backgroundColor = main03?.cgColor
        $0.titleLabel?.font = paragraph01
        $0.addTarget(self, action: #selector(didWriteReviewButtonTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 4
    }
    
    var visitReviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var visitReviewLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "방문 리뷰"
    }
    
    var visitReviewTableView: UITableView = UITableView().then {
        $0.register(VisitReviewTableViewCell.self, forCellReuseIdentifier: "visitReviewCell")
    }
    

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .white
        
        // 스크롤 중첩 방지
        visitReviewTableView.isScrollEnabled = false
        visitReviewTableView.separatorStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            writeReviewView,
            visitReviewView
        ].forEach { self.addSubview($0) }
        
        [
            writeReviewLabel,
            writeReviewButton
        ].forEach { writeReviewView.addSubview($0) }
        
        [
            visitReviewLabel,
            visitReviewTableView
        ].forEach { visitReviewView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        visitReviewTableView.delegate = self
        visitReviewTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        writeReviewView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        writeReviewLabel.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        writeReviewButton.snp.makeConstraints {
            $0.top.equalTo(writeReviewLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(writeReviewView.snp.bottom).offset(-20)
        }
        
        visitReviewView.snp.makeConstraints {
            $0.top.equalTo(writeReviewView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(reviews.count * 500 + 20)
        }
        
        visitReviewLabel.snp.makeConstraints {
            $0.top.equalTo(visitReviewView.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        visitReviewTableView.snp.makeConstraints {
            $0.top.equalTo(visitReviewLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: Functions
    
    // TODO: 리뷰 작성 버튼 눌렀을 때 나오는 화면 구현하고 전환 연결
    @objc func didWriteReviewButtonTapped() {
        BookstoreDetailPageVC().navigationController?.pushViewController(BookStoreReviewDetailVC(), animated: true)
    }
}

// 리뷰 목록 구현을 위한 Delegate와 DataSource 구현
extension BookStoreDetailReviewView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    // 데이터 삽입 구현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = visitReviewTableView.dequeueReusableCell(withIdentifier: "visitReviewCell", for: indexPath) as! VisitReviewTableViewCell
        
        cell.userNameLabel.text = reviews[indexPath.row].userName
        cell.userVisitDateLabel.text = reviews[indexPath.row].visitDate
        cell.commentLabel.text = reviews[indexPath.row].comment
        cell.firstImage.image = UIImage(named: reviews[indexPath.row].photos[0])
        cell.secondImage.image = UIImage(named: reviews[indexPath.row].photos[1])
        cell.thirdImage.image = UIImage(named: reviews[indexPath.row].photos[2])
        cell.fourthImage.image = UIImage(named: reviews[indexPath.row].photos[3])
        
        return cell
    }
    
    // TODO: 사진 유무에 따라 셀 높이 다르게 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailReviewView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailReviewView()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

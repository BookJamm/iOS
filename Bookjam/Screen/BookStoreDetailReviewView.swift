//
//  BookStoreDetailReviewView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailReviewView: UIView {
    
    // MARK: Variables
    
    var reviews: [Review] = [
        Review(userName: "독서 장인", visitDate: "2023 / 06 / 06 방문", comment: "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"]),
        Review(userName: "독서 장인", visitDate: "2023 / 06 / 06 방문", comment: "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"]),
        Review(userName: "독서 장인", visitDate: "2023 / 06 / 06 방문", comment: "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"]),
        Review(userName: "독서 장인", visitDate: "2023 / 06 / 06 방문", comment: "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"])
    ]
    
    var writeReviewView: UIView = UIView()
    
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
    
    var visitReviewView: UIView = UIView()
    
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
    
    @objc func didWriteReviewButtonTapped() {
        
    }
}

extension BookStoreDetailReviewView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
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

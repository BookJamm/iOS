//
//  BookStoreDetailJoinView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 화면 참여 탭 구현

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailActivityView: UIView {

    // MARK: Variables
    
    // 참여 목록 데이터 Activity 배열로 구현
    
    var activities: [Activities] = []
    
    var activityLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "n개의 참여"
    }
    
    var activityTableView: UITableView = UITableView().then {
        $0.register(ActivityTableViewCell.self, forCellReuseIdentifier: "activityCell")
    }

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        // 스크롤 중첩 방지
        activityTableView.isScrollEnabled = false
        activityTableView.separatorStyle = .none
        
        // 참여 목록 수 업데이트
        activityLabel.text = "\(activities.count)개의 참여"
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityLabel,
            activityTableView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        activityTableView.delegate = self
        activityTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        activityTableView.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// 참여 목록 구현을 위한 Delegate, DataSource extension
extension BookStoreDetailActivityView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
//        cell.activityImageView.image = UIImage(named: activities[indexPath.row].photo)
//        cell.descriptionLabel.text = activities[indexPath.row].description
//        cell.activityLabel.text = activities[indexPath.row].name
//        cell.numOfReviewLabel.text = "리뷰 \(String(activities[indexPath.row].numOfReview))"
//        cell.starValueLabel.text = String(activities[indexPath.row].starValue)
        
        if let imageUrlString = activities[indexPath.row].imageUrl {
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
        
        cell.descriptionLabel.text = activities[indexPath.row].info
        cell.activityLabel.text = activities[indexPath.row].title
        cell.numOfReviewLabel.text = "리뷰 \(String(activities[indexPath.row].reviewCount!))"
        cell.starValueLabel.text = String(activities[indexPath.row].totalRating!)
//        
        // 배경 회색으로 구현하고 cornerRadius 적용
        cell.contentView.backgroundColor = gray02
        cell.contentView.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        // 버튼 선택 구현을 위한 selectionStyle 조건 추가
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 셀 높이 480으로 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct BookStoreDetailActivityView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = BookStoreDetailActivityView()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

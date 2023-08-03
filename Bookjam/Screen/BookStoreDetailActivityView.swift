//
//  BookStoreDetailJoinView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailActivityView: UIView {

    // MARK: Variables
    
    var activities: [Activity] = [
        Activity(photo: "squareDefaultImage", name: "행복마실 어르신 책놀이", starValue: 4.93, numOfReview: 584, description: "북 큐레이팅 서비스입니다. 한 달 동안 정기적으로 3권의 책을 보내드립니다. 구매자의 사연과 요청에 따라 가게의 주인장이 추천하는 책을 짧은 메시지와 함께 보내드립니다."),
        Activity(photo: "squareDefaultImage", name: "행복마실 어르신 책놀이", starValue: 4.93, numOfReview: 584, description: "북 큐레이팅 서비스입니다. 한 달 동안 정기적으로 3권의 책을 보내드립니다. 구매자의 사연과 요청에 따라 가게의 주인장이 추천하는 책을 짧은 메시지와 함께 보내드립니다."),
        Activity(photo: "squareDefaultImage", name: "행복마실 어르신 책놀이", starValue: 4.93, numOfReview: 584, description: "북 큐레이팅 서비스입니다. 한 달 동안 정기적으로 3권의 책을 보내드립니다. 구매자의 사연과 요청에 따라 가게의 주인장이 추천하는 책을 짧은 메시지와 함께 보내드립니다.")
    ]
    
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
        activityTableView.isScrollEnabled = false
        activityTableView.separatorStyle = .none
        
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
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        activityTableView.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension BookStoreDetailActivityView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        cell.activityImageView.image = UIImage(named: activities[indexPath.row].photo)
        cell.descriptionLabel.text = activities[indexPath.row].description
        cell.activityLabel.text = activities[indexPath.row].name
        cell.numOfReviewLabel.text = "리뷰 \(String(activities[indexPath.row].numOfReview))"
        cell.starValueLabel.text = String(activities[indexPath.row].starValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailActivityView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailActivityView()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  BookStoreActvityDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/10.
//

// MARK: - 참여 탭에서 활동 별로 참여하기 버튼을 눌렀을 때 나오는 디테일 페이지 구현

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreActvityDetailVC: UIViewController {

    // MARK: Variables
    
    var activities = [Review]()
    
    var scrollView: UIScrollView = UIScrollView()
    
    var contentView: UIView = UIView().then {
        $0.backgroundColor = gray02
    }
    
    var activityView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var activityLabel: UILabel = UILabel().then {
        $0.text = "행복마실 어르신 책놀이"
        $0.font = title03
    }
    
    var heartButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    var activityInfoLabel: UILabel = UILabel().then {
        $0.text = "활동 정보"
        $0.font = title03
        $0.textColor = main03
    }
    
    var activityInfoContentLabel: UILabel = UILabel().then {
        $0.text = "해당 폼은 매월 3일에 열립니다. 북 큐레이팅 서비스는 매달 4만원으로 받아보실 수 있습니다."
        $0.numberOfLines = 4
        $0.font = paragraph02
    }
    
    var numOfPeopleLabel: UILabel = UILabel().then {
        $0.text = "정원"
        $0.font = title03
        $0.textColor = main03
    }
    
    var numOfPeopleContentLabel: UILabel = UILabel().then {
        $0.text = "8/15"
        $0.font = paragraph01
    }
    
    var payInfoLabel: UILabel = UILabel().then {
        $0.text = "결제 정보"
        $0.font = title03
        $0.textColor = main03
    }
    
    var payInfoContentLabel: UILabel = UILabel().then {
        $0.text = "해당 폼은 매월 3일에 열립니다. 북 큐레이팅 서비스는 매달 4만원으로 받아보실 수 있습니다."
        $0.font = paragraph02
        $0.numberOfLines = 4
    }
    
    var kakaoPayButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "KakaoColor")
        $0.setImage(UIImage(named: "KakaoLogo"), for: .normal)
        $0.setTitle(" 카카오 페이 결제", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "191919"), for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.layer.cornerRadius = 8
    }
    
    var depositButton: UIButton = UIButton().then {
        $0.backgroundColor = gray03
        $0.setTitle("무통장 입금", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.layer.cornerRadius = 8
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var ratingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var numOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var reviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var reviewLabel: UILabel = UILabel().then {
        $0.text = "활동 리뷰"
        $0.font = title03
    }
    
    var moreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph05
    }
    
    var reviewTableView: UITableView = UITableView().then {
        $0.register(VisitReviewTableViewCell.self, forCellReuseIdentifier: "visitReviewCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        reviewTableView.separatorStyle = .none
        
        activities = [
            Review(userName: "유짐", visitDate: "2023 / 06 / 05", comment: "집에 보내주세요", photos: []),
            Review(userName: "유짐", visitDate: "2023 / 06 / 05", comment: "집에 보내주세요", photos: [])
        ]
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            activityView,
            reviewView
        ].forEach { contentView.addSubview($0) }
        
        [
            activityLabel,
            heartButton,
            activityImageView,
            activityInfoLabel,
            activityInfoContentLabel,
            numOfPeopleLabel,
            numOfPeopleContentLabel,
            payInfoLabel,
            payInfoContentLabel,
            kakaoPayButton,
            depositButton,
            starImageView,
            ratingLabel,
            numOfReviewLabel
        ].forEach { activityView.addSubview($0) }
        
        [
            reviewLabel,
            moreButton,
            reviewTableView
        ].forEach { reviewView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        activityView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        activityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        heartButton.snp.makeConstraints {
            $0.centerY.equalTo(activityLabel.snp.centerY)
            $0.trailing.equalTo(activityView).offset(-20)
            $0.width.height.equalTo(32)
        }
        
        activityImageView.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
        }
        
        activityInfoLabel.snp.makeConstraints {
            $0.top.equalTo(activityImageView.snp.bottom).offset(24)
            $0.leading.equalTo(activityLabel.snp.leading)
        }
        
        activityInfoContentLabel.snp.makeConstraints {
            $0.top.equalTo(activityInfoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(activityInfoLabel.snp.leading)
            $0.trailing.equalTo(activityImageView.snp.trailing)
        }
        
        numOfPeopleLabel.snp.makeConstraints {
            $0.top.equalTo(activityInfoContentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(activityInfoLabel.snp.leading)
        }
        
        numOfPeopleContentLabel.snp.makeConstraints {
            $0.top.equalTo(numOfPeopleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(numOfPeopleLabel.snp.leading)
        }
        
        payInfoLabel.snp.makeConstraints {
            $0.top.equalTo(numOfPeopleContentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(numOfPeopleLabel.snp.leading)
        }
        
        payInfoContentLabel.snp.makeConstraints {
            $0.top.equalTo(payInfoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(payInfoLabel.snp.leading)
            $0.trailing.equalTo(activityInfoContentLabel.snp.trailing)
        }
        
        kakaoPayButton.snp.makeConstraints {
            $0.top.equalTo(payInfoContentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(activityImageView.snp.leading)
            $0.trailing.equalTo(activityImageView.snp.trailing)
            $0.height.equalTo(44)
        }
        
        depositButton.snp.makeConstraints {
            $0.top.equalTo(kakaoPayButton.snp.bottom).offset(10)
            $0.leading.equalTo(kakaoPayButton)
            $0.trailing.equalTo(kakaoPayButton)
            $0.height.equalTo(44)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(depositButton.snp.bottom).offset(20)
            $0.leading.equalTo(depositButton)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView.snp.centerY)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        numOfReviewLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView.snp.centerY)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(10)
            $0.bottom.equalTo(activityView.snp.bottom).offset(-20)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(activityView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(reviewView).offset(32)
            $0.leading.equalToSuperview().offset(20)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(reviewLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
            $0.bottom.equalTo(reviewView)
        }
    }
    
    
}

// MARK: Extension

extension BookStoreActvityDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "visitReviewCell", for: indexPath) as! VisitReviewTableViewCell
        
        // TODO: 이미지 데이터 삽입하는 부분 구현
        cell.userNameLabel.text = activities[indexPath.row].userName
        cell.userVisitDateLabel.text = activities[indexPath.row].visitDate + " 방문"
        cell.commentLabel.text = activities[indexPath.row].comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

struct BookStoreActvityDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreActvityDetailVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

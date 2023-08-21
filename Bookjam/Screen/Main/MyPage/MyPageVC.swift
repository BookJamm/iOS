//
//  MyPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

// MARK: - 메인 탭바에서 마이 누르면 나오는 마이 페이지 화면

import SwiftUI
import UIKit

import Kingfisher
import SnapKit
import Then


class MyPageVC: UIViewController {

    // MARK: Variables

    var scrollView: UIScrollView = UIScrollView().then {
        $0.backgroundColor = gray02
    }
    
    var contentView: UIView = UIView()
    
    //유저 프로필뷰
    var userProfileView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var userProfileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "BasicProfile")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 45
        
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.text = "userName님"
        $0.font = paragraph01
    }
    
    var myPageSetUpButton: UIButton = UIButton().then {
        $0.setTitle("마이페이지 설정", for: .normal)
        $0.titleLabel?.font = paragraph04
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didMyPageSetUpButtonTapped), for: .touchUpInside)
    }
    
    var userActivityLabel: UILabel = UILabel().then{
        $0.text = "user님의 활동"
        $0.font = paragraph01
    }
    
    var activityFrameView = ActivityFrameView().then{
        $0.backgroundColor = main05
        
    }
    
    // 활동 참여 현황뷰
    var activityParticipateView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var activityParticipateLabel: UILabel = UILabel().then {
        $0.text = "활동 참여 현황"
        $0.font = title06
    }
    
    var activityParticipateMoreButton: UIButton = UIButton().then{
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(main01, for: .normal)
        $0.sizeToFit()
    }
    
    //활동 참여 현황 콜렉션뷰
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    }).then {
        $0.register(ActivityParticipateCollectionViewCell.self, forCellWithReuseIdentifier: ActivityParticipateCollectionViewCell.cellID)
    }
    
    //나의 기록 뷰
    var myRecordView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var myRecordLabel: UILabel = UILabel().then{
        $0.text = "나의 기록"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var myRecordMoreButton: UIButton = UIButton().then{
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(main01, for: .normal)
        $0.sizeToFit()
    }
    
    var independantBookStoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
    }
    
    var bookPlaygroundButton: UIButton = UIButton().then{
        $0.setTitle("책놀이터", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
    }
    
    var etcButton: UIButton = UIButton().then{
        $0.setTitle("기타", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
    }
    
    var myRecordBookStoreView = MyRecordBookStoreView()
    
    var myRecordBookStoreView2 = MyRecordBookStoreView()
    
    //나의 리뷰뷰
    var myReviewView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var myReviewLabel: UILabel = UILabel().then{
        $0.text = "나의 리뷰"
        $0.font = title06
        $0.sizeToFit()
    }
    var myReviewMoreButton: UIButton = UIButton().then{
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(main01, for: .normal)
        $0.sizeToFit()
    }
    var myReviewBookStoreView = MyReviewBookStoreView()
    
    var myReviewBookStoreView2 = MyReviewBookStoreView()
    
    //  좋아요한 활동 뷰
    
    var likeActivityView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    var likeActivityLabel: UILabel = UILabel().then{
        $0.text = "좋아요한 활동"
        $0.font = title06
        $0.sizeToFit()
    }
    var likeActivityMoreButton: UIButton = UIButton().then{
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(main01, for: .normal)
        $0.sizeToFit()
    }
    var likeActivityBookStoreView = LikeActivityBookStoreView()
    var likeActivityBookStoreView2 = LikeActivityBookStoreView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAPI()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    

    // MARK: View
    
    func setUpAPI() {
        /// 마이페이지 정보 요약 API 불러오기
        APIManager.shared.getData(
            urlEndpointString: Constant.getUsersOutline,
            responseDataType: APIModel<UsersOutlineResponseModel>?.self,
            requestDataType: UsersOutlineRequestModel.self,
            parameter: nil) { response in
                if let result = response?.result?.userOutline?[0] {
                    self.userNameLabel.text = "\(result.username!)님"
                    self.userActivityLabel.text = "\(result.username!)님의 활동"
                    self.activityFrameView.recordNumberLabel.text = "\(result.record_count!)"
                    self.activityFrameView.reviewNumberLabel.text = "\(result.review_count!)"
                    self.userProfileImageView.kf.setImage(with: URL(string: result.profile_image ?? ""), placeholder: UIImage(named: "BasicProfile"))
                    // TODO: 방문 수 더미로 두고 서버 연결되면 수정
                    self.activityFrameView.visitNumberLabel.text = "33"
                }
            }
        
        /// 리뷰 API 불러오기
        APIManager.shared.getData(
            urlEndpointString: Constant.getUsersReviews,
            responseDataType: APIModel<UsersReviewsResponseModel>?.self,
            requestDataType: UsersReviewsRequestModel.self,
            parameter: nil) { response in
                if let reviews = response?.result?.userReviews  {
                    if reviews.count == 0 {
                        self.myReviewBookStoreView.isHidden = true
                        self.myReviewBookStoreView2.isHidden = true
                    }
                    else if reviews.count == 1 {
                        self.myReviewBookStoreView2.isHidden = true
                        
                        let date = reviews[0].visited_at!.components(separatedBy: "T")[0]
                        
                        self.myReviewBookStoreView.bookStoreName.text = reviews[0].name
                        self.myReviewBookStoreView.bookNameButton.setTitle("아몬드", for: .normal)
                        self.myReviewBookStoreView.speechBubbleLabel.text = "2"
                        self.myReviewBookStoreView.heartLabel.text = "3"
                        self.myReviewBookStoreView.visitDayLabel.text = "\(date) 방문"
                        self.myReviewBookStoreView.bookStoreImageView.kf.setImage(with: URL(string: reviews[0].image_url!), placeholder: UIImage(named: "squareDefaultImage"))
                    }
                    else {
                        let firstDate = reviews[0].visited_at!.components(separatedBy: "T")[0]
                        let secondDate = reviews[1].visited_at!.components(separatedBy: "T")[0]
                        
                        self.myReviewBookStoreView.bookStoreName.text = reviews[0].name
                        self.myReviewBookStoreView.bookNameButton.setTitle("아몬드", for: .normal)
                        self.myReviewBookStoreView.speechBubbleLabel.text = "2"
                        self.myReviewBookStoreView.heartLabel.text = "3"
                        self.myReviewBookStoreView.visitDayLabel.text = "\(firstDate) 방문"
                        self.myReviewBookStoreView.bookStoreImageView.kf.setImage(with: URL(string: reviews[0].image_url ?? ""), placeholder: UIImage(named: "squareDefaultImage"))
                        
                        self.myReviewBookStoreView2.bookStoreName.text = reviews[1].name
                        self.myReviewBookStoreView2.bookNameButton.setTitle("불편한 편의점", for: .normal)
                        self.myReviewBookStoreView2.speechBubbleLabel.text = "4"
                        self.myReviewBookStoreView2.heartLabel.text = "2"
                        self.myReviewBookStoreView2.visitDayLabel.text = "\(secondDate) 방문"
                        self.myReviewBookStoreView2.bookStoreImageView.kf.setImage(with: URL(string: reviews[1].image_url ?? ""), placeholder: UIImage(named: "squareDefaultImage"))
                    }
                }
            }
    }
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            userProfileView,
            activityParticipateView,
            myRecordView,
            myReviewView,
            likeActivityView
        ].forEach { contentView.addSubview($0) }
        
        [
            userProfileImageView,
            userNameLabel,
            myPageSetUpButton,
            userActivityLabel,
            activityFrameView,
        ].forEach{ userProfileView.addSubview($0) }
        
        [
            activityParticipateLabel,
            activityParticipateMoreButton,
            collectionView
        ].forEach{ activityParticipateView.addSubview($0) }
        
        [
            myRecordLabel,
            myRecordMoreButton,
            independantBookStoreButton,
            bookPlaygroundButton,
            libraryButton,
            etcButton,
            myRecordBookStoreView,
            myRecordBookStoreView2
        ].forEach{ myRecordView.addSubview($0) }
        
        [
            myReviewLabel,
            myReviewMoreButton,
            myReviewBookStoreView,
            myReviewBookStoreView2
        ].forEach{ myReviewView.addSubview($0) }
        
        [
            likeActivityLabel,
            likeActivityMoreButton,
            likeActivityBookStoreView,
            likeActivityBookStoreView2
        ].forEach{ likeActivityView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        //스크롤뷰
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        contentView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1650)
        }
        
        //유저 프로필뷰
        userProfileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }
        userProfileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(90)
        }
        userNameLabel.snp.makeConstraints{
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(20)
            $0.centerY.equalTo(userProfileImageView).offset(-10)
        }
        myPageSetUpButton.snp.makeConstraints{
            $0.top.equalTo(userNameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(userNameLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(33)
        }
        userActivityLabel.snp.makeConstraints{
            $0.top.equalTo(myPageSetUpButton.snp.bottom).offset(20)
            $0.centerX.equalTo(userProfileImageView)
            
        }
        activityFrameView.snp.makeConstraints{
            $0.top.equalTo(userActivityLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        // 활동 참여 현황 뷰
        activityParticipateView.snp.makeConstraints{
            $0.top.equalTo(userProfileView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(220)
        }
        activityParticipateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(activityFrameView)
        }
        activityParticipateMoreButton.snp.makeConstraints{
            $0.centerY.equalTo(activityParticipateLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        collectionView.snp.makeConstraints{
            $0.top.equalTo(activityParticipateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(activityParticipateLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(144)
        }
        
        //나의 기록 뷰
        myRecordView.snp.makeConstraints{
            $0.top.equalTo(activityParticipateView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        myRecordLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        myRecordMoreButton.snp.makeConstraints{
            $0.centerY.equalTo(myRecordLabel)
            $0.trailing.equalToSuperview().offset(-20)
            
        }
        independantBookStoreButton.snp.makeConstraints{
            $0.top.equalTo(myRecordLabel.snp.bottom).offset(20)
            $0.leading.equalTo(myRecordLabel)
            $0.width.equalTo(100)
        }
        bookPlaygroundButton.snp.makeConstraints{
            $0.top.width.equalTo(independantBookStoreButton)
            $0.leading.equalTo(independantBookStoreButton.snp.trailing).offset(10)
            
        }
        libraryButton.snp.makeConstraints{
            $0.top.equalTo(independantBookStoreButton)
            $0.leading.equalTo(bookPlaygroundButton.snp.trailing).offset(10)
            $0.width.equalTo(80)
            
        }

        myRecordBookStoreView.snp.makeConstraints{
            $0.top.equalTo(independantBookStoreButton.snp.bottom).offset(20)
            $0.leading.equalTo(independantBookStoreButton)
            $0.trailing.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(160)
            
        }
        
        myRecordBookStoreView2.snp.makeConstraints{
            $0.top.equalTo(myRecordBookStoreView)
            $0.height.equalTo(160)
            $0.leading.equalTo(myRecordBookStoreView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        //나의 리뷰 뷰
        myReviewView.snp.makeConstraints{
            $0.top.equalTo(myRecordView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(myRecordView)
        }
        myReviewLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        myReviewMoreButton.snp.makeConstraints{
            $0.centerY.equalTo(myReviewLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        myReviewBookStoreView.snp.makeConstraints{
            $0.top.equalTo(myReviewLabel.snp.bottom).offset(20)
            $0.leading.equalTo(myReviewLabel)
            $0.trailing.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(200)
        }
        myReviewBookStoreView2.snp.makeConstraints{
            $0.top.equalTo(myReviewBookStoreView)
            $0.leading.equalTo(myReviewBookStoreView.snp.trailing).offset(10)
            $0.height.equalTo(160)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        //좋아요한 활동 뷰
        likeActivityView.snp.makeConstraints{
            $0.top.equalTo(myReviewView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(myReviewView)
        }
        likeActivityLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        likeActivityMoreButton.snp.makeConstraints{
            $0.centerY.equalTo(likeActivityLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        likeActivityBookStoreView.snp.makeConstraints{
            $0.top.equalTo(likeActivityLabel.snp.bottom).offset(20)
            $0.leading.equalTo(likeActivityLabel)
            $0.height.equalTo(160)
            $0.trailing.equalToSuperview().multipliedBy(0.49)
        }
        likeActivityBookStoreView2.snp.makeConstraints{
            $0.top.equalTo(likeActivityBookStoreView)
            $0.leading.equalTo(likeActivityBookStoreView.snp.trailing).offset(10)
            $0.height.equalTo(160)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }//end of constraint
    
    // MARK: Function
    //  마이페이지 설정 눌렀을 때 UserPageVC로 전환
    @objc func didMyPageSetUpButtonTapped() {
        navigationController?.pushViewController(UserPageVC(), animated: true)
    }
    
}

extension MyPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityParticipateCollectionViewCell.cellID, for: indexPath) as? ActivityParticipateCollectionViewCell else { return UICollectionViewCell() }
        
        //        cell.contentView.backgroundColor = gray01
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

struct MyPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MyPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

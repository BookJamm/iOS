//
//  MyPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

// MARK: - 메인 탭바에서 마이 누르면 나오는 마이 페이지 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class MyPageVC: UIViewController {

    // MARK: Variables

    var scrollView: UIScrollView = UIScrollView().then {
        $0.backgroundColor = gray02
    }
    
    var contentView: UIView = UIView()
    
    var userProfileView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var userProfileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "BasicProfile")
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
    }
    
    var userActivityLabel: UILabel = UILabel().then{
        $0.text = "user님의 활동"
        $0.font = paragraph01
    }
    
    var activityFrameView: UIView = UIView().then{
        $0.backgroundColor = main05
    }
    
    var activityParticipateView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var activityParticipateLabel: UILabel = UILabel().then {
        $0.text = "활동 참여 현황"
        $0.font = title06
    }
    
    //활동 참여 현황 콜렉션뷰
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    }).then{
        $0.backgroundColor = .white
        $0.register(ActivityParticipateCollectionViewCell.self, forCellWithReuseIdentifier: ActivityParticipateCollectionViewCell.cellID)
    }
    
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
    
    //나의 기록
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    

    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            userProfileView,
            activityParticipateView,
            myRecordView,
            myReviewView
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
            collectionView
        ].forEach{ activityParticipateView.addSubview($0) }
        
        [
            myRecordLabel,
            myRecordMoreButton,
            independantBookStoreButton,
            bookPlaygroundButton,
            libraryButton,
            etcButton,
            myRecordBookStoreView
        ].forEach{ myRecordView.addSubview($0) }
        
        [
        myReviewLabel,
        myReviewMoreButton,
        myReviewBookStoreView,
        ].forEach{ myReviewView.addSubview($0) }
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
            $0.height.equalTo(2000)
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
            $0.top.equalTo(userProfileView.snp.bottom).offset(2)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(220)
        }
        activityParticipateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(activityFrameView)
        }
        collectionView.snp.makeConstraints{
            $0.top.equalTo(activityParticipateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(activityParticipateLabel)
            $0.height.equalTo(200)
            
        }
        
        //나의 기록 뷰
        myRecordView.snp.makeConstraints{
            $0.top.equalTo(activityParticipateView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        myRecordLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        myRecordMoreButton.snp.makeConstraints{
            $0.centerY.equalTo(myRecordLabel)
            $0.trailing.equalToSuperview().offset(-20)
            
        }
        independantBookStoreButton.snp.makeConstraints{
            $0.top.equalTo(myRecordLabel.snp.bottom).offset(15)
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
        etcButton.snp.makeConstraints{
            $0.top.equalTo(independantBookStoreButton)
            $0.leading.equalTo(libraryButton.snp.trailing).offset(10)
            $0.width.equalTo(68)
        }
        myRecordBookStoreView.snp.makeConstraints{
            $0.top.equalTo(independantBookStoreButton.snp.bottom).offset(10)
            $0.leading.equalTo(independantBookStoreButton)
            $0.trailing.equalToSuperview().multipliedBy(0.5)
            $0.height.width.equalTo(200)
        }
        
        //나의 리뷰 뷰
        myReviewView.snp.makeConstraints{
            $0.top.equalTo(myRecordView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        myReviewLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
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
            $0.height.width.equalTo(200)
        }
    }
    
}

extension MyPageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityParticipateCollectionViewCell.cellID, for: indexPath) as? ActivityParticipateCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

struct MyPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MyPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

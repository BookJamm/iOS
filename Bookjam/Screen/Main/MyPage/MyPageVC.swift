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
    
    var myRecordView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var myRecordLabel: UILabel = UILabel().then{
        $0.text = "나의 기록"
        $0.font = paragraph01
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
        $0.setTitle("도서관", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
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
            myRecordView
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
        ].forEach{ activityParticipateView.addSubview($0)}
        
        [
            myRecordLabel,
            myRecordMoreButton,
            independantBookStoreButton,
            bookPlaygroundButton,
            libraryButton,
            etcButton,
        ].forEach{ myRecordView.addSubview($0) }
        
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        contentView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
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
        
    }
    
}

struct MyPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MyPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

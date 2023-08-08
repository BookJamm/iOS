//
//  UserPageVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/08.
//

// MARK: - 마이페이지에서 프로필 수정하기 버튼을 눌렀을 때 넘어오는 유저 페이지 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class UserPageVC: UIViewController {

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
        $0.text = "userName"
        $0.font = paragraph01
    }
    
    var personalInfoView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var personalInfoLabel: UILabel = UILabel().then {
        $0.text = "개인정보"
        $0.font = title06
    }
    
    var changeNicknameButton: UIButton = UIButton().then {
        $0.setTitle("프로필 / 닉네임 변경", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(.black, for: .normal)
        $0.sizeToFit()
    }
    
    var changePasswordButton: UIButton = UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(.black, for: .normal)
        $0.sizeToFit()
    }
    
    var alertSettingButton: UIButton = UIButton().then {
        $0.setTitle("알림 설정", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(.black, for: .normal)
    }
    
    var alertToggleButton: UISwitch = UISwitch().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var myActivityView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var myActivityLabel: UILabel = UILabel().then {
        $0.text = "내 활동"
        $0.font = title06
    }
    
    var myPostButton: UIButton = UIButton().then {
        $0.setTitle("내가 쓴 글", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(.black, for: .normal)
        $0.sizeToFit()
    }
    
    var myCommentButton: UIButton = UIButton().then {
        $0.setTitle("내가 쓴 댓글", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(.black, for: .normal)
        $0.sizeToFit()
    }
    
    var logoutButton: UIButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(alert, for: .normal)
        $0.sizeToFit()
    }
    
    var deleteAccountButton: UIButton = UIButton().then {
        $0.setTitle("계정 탈퇴", for: .normal)
        $0.titleLabel?.font = paragraph03
        $0.setTitleColor(gray05, for: .normal)
        $0.sizeToFit()
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
            personalInfoView,
            myActivityView,
        ].forEach { contentView.addSubview($0) }
        [
            userProfileImageView,
            userNameLabel
        ].forEach { userProfileView.addSubview($0) }
        [
            personalInfoLabel,
            changeNicknameButton,
            changePasswordButton,
            alertToggleButton,
            alertSettingButton
        ].forEach { personalInfoView.addSubview($0) }
        [
            myActivityLabel,
            myPostButton,
            myCommentButton,
            logoutButton,
            deleteAccountButton
        ].forEach { myActivityView.addSubview($0) }
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
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        userProfileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.top).offset(20)
            $0.centerX.equalTo(userProfileView)
            $0.width.height.equalTo(90)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(10)
            $0.centerX.equalTo(userProfileImageView)
        }
        
        personalInfoView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(contentView)
        }
        
        personalInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(20)
        }
        
        changeNicknameButton.snp.makeConstraints {
            $0.top.equalTo(personalInfoLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        changePasswordButton.snp.makeConstraints {
            $0.top.equalTo(changeNicknameButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        alertSettingButton.snp.makeConstraints {
            $0.top.equalTo(changePasswordButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        alertToggleButton.snp.makeConstraints {
            $0.centerY.equalTo(alertSettingButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        myActivityView.snp.makeConstraints {
            $0.top.equalTo(personalInfoView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        myActivityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34)
            $0.leading.equalToSuperview().offset(20)
        }
        
        myPostButton.snp.makeConstraints {
            $0.top.equalTo(myActivityLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        myCommentButton.snp.makeConstraints {
            $0.top.equalTo(myPostButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(myCommentButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        deleteAccountButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}

struct UserPageVC_Preview: PreviewProvider {
    static var previews: some View {
        UserPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

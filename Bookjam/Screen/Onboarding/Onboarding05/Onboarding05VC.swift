//
//  Onboarding05VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

// MARK: - 가입 완료 전 이메일로 친구 검색하는 화면

import SwiftUI
import UIKit

import FloatingPanel
import Kingfisher
import SnapKit
import Then


class Onboarding05VC: UIViewController, FloatingPanelControllerDelegate {
    
    // MARK: Variables
    
    /// 추천 친구 api로 불러온 친구 정보 할당할 변수 선언
    var recommendFriends = [RecommendFriend]()
    
    let informationLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "BOOKJAM을 함께 즐길 친구를\n함께 찾아봐요!"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.sizeToFit()
    }
    
    let searchIDLabel: UILabel = UILabel().then {
        $0.textColor = UIColor(hexCode: "6F6F6F")
        $0.textAlignment = .left
        $0.text = "아이디로 검색하기"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.sizeToFit()
    }
    
    let searchButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = UIColor(named: "MainColor")
        $0.addTarget(self, action: #selector(didSearchButtonTapped), for: .touchUpInside)
    }
    
    let emailTextField: UITextField = UITextField().then {
        $0.placeholder = "bookjam@email.com"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    let bottomLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    let recommendLabel: UILabel = UILabel().then {
        $0.font = title03
        $0.textColor = gray07
        $0.text = "추천 친구"
    }
    
    let recommendTableView: UITableView = UITableView().then {
        $0.register(FriendInfoTableViewCell.self, forCellReuseIdentifier: FriendInfoTableViewCell().cellID)
    }
    
    let finishButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("완료하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(didFinishButtonTapped), for: .touchUpInside)
    }
    
    let floatingPanel: FloatingPanelController = FloatingPanelController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        /// 추천 친구 테이블 뷰 구분 선 없애고 스크롤 안되게 설정
        recommendTableView.separatorStyle = .none
        recommendTableView.isScrollEnabled = false
        
        /// 화면 밖 클릭하면 키보드 내려가게 설정
        hideKeyboard()
        
        /// 추천 친구 테이블 뷰에 할당할 친구 데이터 불러오는 부분
        callRecommendFriendData()
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            informationLabel,
            searchIDLabel,
            emailTextField,
            searchButton,
            bottomLineView,
            recommendLabel,
            recommendTableView,
            finishButton
        ].forEach { view.addSubview($0) }
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        floatingPanel.delegate = self
        
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.78)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        searchIDLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.47)
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(1.78)
            $0.centerY.equalToSuperview().multipliedBy(0.65)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalTo(searchIDLabel.snp.leading)
            $0.centerY.equalToSuperview().multipliedBy(0.65)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalToSuperview().multipliedBy(0.0011)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.72)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(bottomLineView.snp.bottom).offset(40)
            $0.leading.equalTo(searchIDLabel)
        }
        
        recommendTableView.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(20)
            $0.leading.equalTo(recommendLabel)
            $0.trailing.equalTo(bottomLineView)
            $0.height.equalTo(300)
        }
        
        finishButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
    }
    
    
    // MARK: Functions
    
    /// searchButton 누르면 floatingPanel 올라오게 구현
    /// searchButton에 addTarget으로 연결
    @objc func didSearchButtonTapped() {
        // MARK: 서버 API 연결
        let email = emailTextField.text
        
        APIManager.shared.getData(
            urlEndpointString: Constant.getSearchUser,
            responseDataType: APIModel<[SearchFriendResponseModel]>?.self,
            requestDataType: SearchFriendRequestModel.self,
            parameter: SearchFriendRequestModel(email: email),
            completionHandler: {
                response in
                // TODO: 서버 api 완성되면 SearchFriendResponseModel 수정해서 연결
                print(response)
//                if let result = response?.result {
//                    print(re)
//                }
            })
        
        
        floatingPanel.addPanel(toParent: self)
        floatingPanel.set(contentViewController: Onboarding05BottomSheet())
        floatingPanel.hide()
        floatingPanel.show(animated: true)
    }
    
    /// 완료하기 버튼 누르면 가입 완료 창으로 넘어가게 구현
    /// 가입 완료 창은 이전으로 못 돌아오도록 Navigation 말고 present로 구현
    /// finishButton에 addTarget으로 구현
    @objc func didFinishButtonTapped() {
        let onboarding06VC = Onboarding06VC()
        onboarding06VC.modalPresentationStyle = .fullScreen
        
        self.present(onboarding06VC, animated: true)
    }
    
    /// 추천 친구 테이블 뷰에 할당할 친구 데이터 api로 불러오는 함수
    func callRecommendFriendData() {
        APIManager.shared.getData(
            urlEndpointString: Constant.getAuthFriends,
            responseDataType: APIModel<RecommendFriendResponseModel>?.self,
            requestDataType: RecommendFriendRequestModel.self,
            parameter: nil) { response in
                self.recommendFriends = response!.result!.recommendFriends
                
                self.recommendTableView.reloadData()
            }
    }
}


// MARK: Extension

extension Onboarding05VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendInfoTableViewCell().cellID, for: indexPath) as! FriendInfoTableViewCell
        
        cell.nicknameLabel.text = recommendFriends[indexPath.row].username!
        cell.profileImageView.kf.setImage(
            with: URL(string: recommendFriends[indexPath.row].profile_image ?? "https://github.com/BookJamm/FE/assets/80394340/8a24f8d8-77e4-47da-b171-9dd272bf4530"),
            placeholder: nil,
            options: [.transition(.fade(0.5))],
            progressBlock: nil)
        cell.emailLabel.text = recommendFriends[indexPath.row].email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

struct Onboarding05VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding05VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

//
//  Onboarding05VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

// MARK: - 가입 완료 전 이메일로 친구 검색하는 화면

import SwiftUI
import UIKit

import Alamofire
import FloatingPanel
import SnapKit
import Then


class Onboarding05VC: UIViewController, FloatingPanelControllerDelegate {
    
    // MARK: Variables
    
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
        
        hideKeyboard() // 화면 밖 클릭하면 키보드 내려가게 설정
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(informationLabel)
        view.addSubview(searchIDLabel)
        view.addSubview(emailTextField)
        view.addSubview(searchButton)
        view.addSubview(bottomLineView)
        view.addSubview(finishButton)
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
        
        finishButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.94)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
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
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        floatingPanel.delegate = self
    }
    
    
    // MARK: Functions
    
    // searchButton 누르면 floatingPanel 올라오게 구현
    // searchButton에 addTarget으로 연결
    @objc func didSearchButtonTapped() {
        // MARK: 서버 API 연결
        let email = emailTextField.text
        
        APIManager.shared.getData(
            urlEndpointString: Constant.searchFriend,
            responseDataType: APIModel<SearchFriendResponseModel>?.self,
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
    } // end of didSearchImageViewTapped()
    
    // 완료하기 버튼 누르면 가입 완료 창으로 넘어가게 구현
    // 가입 완료 창은 이전으로 못 돌아오도록 Navigation 말고 present로 구현
    // finishButton에 addTarget으로 구현
    @objc func didFinishButtonTapped() {
        let onboarding06VC = Onboarding06VC()
        onboarding06VC.modalPresentationStyle = .fullScreen
        
        self.present(onboarding06VC, animated: true)
    } // end of didFinishButtonTapped()
}

struct Onboarding05VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding05VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

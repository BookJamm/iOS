//
//  RecommendFriendPopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/22.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class RecommendFriendPopUpVC: UIViewController {

    // MARK: Variables
    
    let popUpView: UIView = UIView().then {
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let searchResult: [Friend] = [
        Friend(nickname: "짐깅", email: "kynhun20@gachon.ac.kr", photoURL: "", isFriend: false)
    ]
    
    let searchLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "검색 결과"
        $0.font = title06
        $0.sizeToFit()
    }
    
    let searchResultTableView: UITableView = UITableView().then {
        $0.backgroundColor = UIColor(hexCode: "F5F4F3")
        $0.register(FriendInfoTableViewCell.self, forCellReuseIdentifier: "friendInfoCell")
    }
    
    let addFinishButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.layer.cornerRadius = 8
        $0.setTitle("추가 완료", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = paragraph01
         $0.addTarget(self, action: #selector(didAddFinishButtonTapped), for: .touchUpInside)
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
        view.backgroundColor = .clear
        searchResultTableView.separatorStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(popUpView)
        [
            searchLabel,
            searchResultTableView,
            addFinishButton
        ].forEach { popUpView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        popUpView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(1.6)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(30)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-70)
        }
        
        addFinishButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
    }
    
    
    // MARK: Function
    
    /// 추가 완료 버튼 누르면 Onboarding05VC에서 내려가도록 설정
    @objc func didAddFinishButtonTapped() {
        self.dismiss(animated: true)
    }
    
}


// MARK: Extension

// searchResultTableView 구현을 위한 Delegate, DataSource extension 선언
extension RecommendFriendPopUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    // cell 높이 값 80으로 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // 셀에 데이터 할당해서 return
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "friendInfoCell", for: indexPath) as! FriendInfoTableViewCell
        let buttonImage: String = searchResult[indexPath.row].isFriend ? "removeButton" : "addButton"
        
        cell.contentView.backgroundColor = gray02
        // TODO: 나중에 URL로 값 받아오면 image 연결 가능하도록 구현
        // cell.profileImageView.image = searchResult[indexPath.row].photoURL
        cell.nicknameLabel.text = searchResult[indexPath.row].nickname
        cell.emailLabel.text = searchResult[indexPath.row].email
        cell.addFriendButton.setImage(UIImage(named: buttonImage), for: .normal)
        
        return cell
    }
}
//
//struct RecommendFriendPopUpVC_Preview: PreviewProvider {
//    static var previews: some View {
//        RecommendFriendPopUpVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}

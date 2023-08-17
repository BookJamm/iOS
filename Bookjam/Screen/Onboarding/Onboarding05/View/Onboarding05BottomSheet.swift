//
//  Onboarding05BottomSheetVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/22.
//

import SwiftUI
import UIKit

import Alamofire
import FloatingPanel
import SnapKit
import Then


class Onboarding05BottomSheet: UIViewController {
    
    // MARK: Variable
    
    let searchResult: [Friend] = [
        Friend(nickname: "짐깅", email: "kynhun20@gachon.ac.kr", photoURL: "", isFriend: false)
    ]
    
    let searchLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "검색 결과"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         $0.addTarget(self, action: #selector(didAddFinishButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }

    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = UIColor(hexCode: "F5F4F3")
        self.searchResultTableView.separatorStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            searchLabel,
            searchResultTableView,
            addFinishButton
        ].forEach { view.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        searchLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview().multipliedBy(0.1)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.bottom.equalToSuperview().multipliedBy(0.9)
        }
        
        addFinishButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.97)
        }
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    
    // MARK: Function
    
    // 추가 완료 버튼 누르면 Onboarding05VC에서 내려가도록 설정
    @objc func didAddFinishButtonTapped() {
        self.dismiss(animated: true)
    }
}


// searchResultTableView 구현을 위한 Delegate, DataSource extension 선언
extension Onboarding05BottomSheet: UITableViewDelegate, UITableViewDataSource {
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

struct Onboarding05BottomSheet_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding05BottomSheet().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

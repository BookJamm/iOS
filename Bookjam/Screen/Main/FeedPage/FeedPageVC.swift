//
//  FeedVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/31.
//

// MARK: - 메인 탭바에서 피드 누르면 나오는 친구 페이지 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class FeedPageVC: UIViewController {

    // MARK: Variables
    
    var records = [RecordsFriendResponseModel]()
    
    var searchView: UIView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = main03?.cgColor
        $0.layer.borderWidth = 1
    }
    
    var userSearchButton: UIButton = UIButton().then {
        $0.setTitle(" 이메일 또는 게시물 키워드 검색", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = main03
        $0.addTarget(self, action: #selector(didUserSearchButtonTapped), for: .touchUpInside)
    }
    
    var feedTableView: UITableView = UITableView().then {
        $0.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell().cellID)
    }
    
    var writePostButton: UIButton = UIButton().then {
        $0.backgroundColor = main03
        $0.setImage(UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 20, weight: .black, scale: .large)),for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 32
        $0.addTarget(self, action: #selector(didWritePostButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAPI()
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        setUpNotification()
    }
    
    
    // MARK: API
    
    func setUpAPI() {
        APIManager.shared.getData(
            urlEndpointString: Constant.getRecordsFriends,
            responseDataType: APIModel<[RecordsFriendResponseModel]>.self,
            requestDataType: RecordsFriendRequestModel.self,
            parameter: nil) { response in
                if let result = response.result {
                    self.records = result
                    
                    self.feedTableView.reloadData()
                }
            }
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            searchView,
            feedTableView,
            writePostButton
        ].forEach { view.addSubview($0) }
        
        searchView.addSubview(userSearchButton)
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
        }
        
        userSearchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        feedTableView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        writePostButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.width.height.equalTo(64)
        }
    }
    
    
    // MARK: Function
    
    @objc func didUserSearchButtonTapped() {
        let searchPage = UserSearchPageVC()
        searchPage.modalPresentationStyle = .fullScreen
        searchPage.modalTransitionStyle = .coverVertical
        
//        self.present(searchPage, animated: true)
        
        navigationController?.pushViewController(searchPage, animated: true)
    }
    
    @objc func didWritePostButtonTapped() {
        let postPage = FeedPostPageVC()
        postPage.modalPresentationStyle = .fullScreen
        postPage.modalTransitionStyle = .coverVertical
        
        self.present(postPage, animated: true)
    }
    
    @objc func postData() {
        APIManager.shared.getData(
            urlEndpointString: Constant.getRecordsFriends,
            responseDataType: APIModel<[RecordsFriendResponseModel]>.self,
            requestDataType: RecordsFriendRequestModel.self,
            parameter: nil) { response in
                if let result = response.result {
                    self.records = result
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.feedTableView.reloadData()
                    }
                }
            }
    }
    
    
    // MARK: Notification
    
    func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("feedPostCheckButtonTapped"), object: nil)
    }
}


// MARK: Extension

extension FeedPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell().cellID, for: indexPath) as! FeedPostTableViewCell
        
        cell.images = records[indexPath.row].images_url ?? []
        cell.userNameLabel.text = records[indexPath.row].username
        cell.timeLabel.text = records[indexPath.row].date.components(separatedBy: "T")[0]
        cell.contextLabel.text = records[indexPath.row].contents
        if let bookLabelText = records[indexPath.row].book{
            cell.bookLabel.text = bookLabelText
        }else{
            cell.bookLabel.text = "책을 선택하지 않았습니다."
        }
        
        
        cell.commentLabel.text = String(records[indexPath.row].comment_count)
        cell.heartLabel.text = String(records[indexPath.row].like_count)
        
        cell.selectionStyle = .none

        return cell
    }
}

//struct FeedPageVC_Preview: PreviewProvider {
//    static var previews: some View {
//        FeedPageVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}

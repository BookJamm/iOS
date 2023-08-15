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

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
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
        
        self.present(searchPage, animated: true)
    }
    
    @objc func didWritePostButtonTapped() {
        let postPage = FeedPostPageVC()
        postPage.modalPresentationStyle = .fullScreen
        postPage.modalTransitionStyle = .coverVertical
        
        self.present(postPage, animated: true)
    }
}


// MARK: Extension

extension FeedPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell().cellID, for: indexPath) as! FeedPostTableViewCell
        
        return cell
    }
}

struct FeedPageVC_Preview: PreviewProvider {
    static var previews: some View {
        FeedPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

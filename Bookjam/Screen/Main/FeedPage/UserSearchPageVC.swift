//
//  UserSearchPageVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class UserSearchPageVC: UIViewController {

    // MARK: Variables
    
    var backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
    }
    
    var searchBar: UISearchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = main03?.cgColor
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        $0.tintColor = main03
        $0.placeholder = "이메일 또는 게시물 키워드 검색"
    }
    
    /// 서점 세부 내용 전환해주는 SegmentedControl
    var segmentController: UISegmentedControl = UISegmentedControl().then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: gray04!,
            NSAttributedString.Key.font: paragraph03
        ], for: .normal)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: main03!,
            NSAttributedString.Key.font: paragraph03
        ], for: .selected)
        
        /// segments 삽입
        $0.insertSegment(withTitle: "유저", at: 0, animated: true)
        $0.insertSegment(withTitle: "게시물", at: 1, animated: true)

        /// 기본 탭은 유저로 설정
        $0.selectedSegmentIndex = 0
        
        /// 값 바뀌면 didFeedSegmentControllerValueChanged 호출
        $0.addTarget(self, action: #selector(didFeedSegmentControllerValueChanged), for: .valueChanged)
    }
    
    var segmentControlUnderlineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var segmentControlSelectedUnderLineView: UIView = UIView().then {
        $0.backgroundColor = main03
    }
    
    var userTableView: UITableView = UITableView().then {
        $0.register(FeedUserTableViewCell.self, forCellReuseIdentifier: FeedUserTableViewCell().cellID)
    }
    
    var postTableView: UITableView = UITableView().then {
        $0.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell().cellID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        
        navigationItem.titleView = searchBar
        
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        postTableView.isHidden = true
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
//            backButton,
            searchBar,
            segmentController,
            segmentControlUnderlineView,
            segmentControlSelectedUnderLineView,
            userTableView,
            postTableView
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        userTableView.dataSource = self
        userTableView.delegate = self
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
//        backButton.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.leading.equalToSuperview().offset(20)
//        }
        
//        searchBar.snp.makeConstraints {
////            $0.centerY.equalTo(backButton)
//            //            $0.leading.equalTo(backButton.snp.trailing).offset(10)
//
//            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(10)
//            $0.leading.equalToSuperview().offset(10)
//            $0.trailing.equalToSuperview().offset(-10)
//            $0.height.equalTo(45)
//        }
        
        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview().offset(-10)
//            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }

        segmentControlUnderlineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }

        segmentControlSelectedUnderLineView.snp.makeConstraints {
            $0.width.equalTo(segmentController).dividedBy(2)
            $0.height.equalTo(2)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }
        
        userTableView.snp.makeConstraints {
            $0.top.equalTo(segmentControlSelectedUnderLineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        postTableView.snp.makeConstraints {
            $0.top.equalTo(segmentControlSelectedUnderLineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    // MARK: Function
    
    @objc func didBackButtonTapped() {
        self.dismiss(animated: true)
    }
    
    /// SegmentedControl에서 세그먼트의 값이 변경되었을 경우 호출되는 메소드
    @objc private func didFeedSegmentControllerValueChanged() {
        let segmentIndex = CGFloat(segmentController.selectedSegmentIndex)
        let segmentWidth = segmentController.frame.width / CGFloat(segmentController.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        /// segmentIndex 따라서 segmentControlSelectedUnderLineView 위치 업데이트
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            guard let self = self else { return }
            self.segmentControlSelectedUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(20 + leadingDistance)
            }
        })
        
        /// segmentIndex 따라서 화면 전환
        /// 유저 탭
        if segmentIndex == 0 {
            postTableView.isHidden = true
            userTableView.isHidden = false
        }
        /// 게시물 탭
        else if segmentIndex == 1 {
            postTableView.isHidden = false
            userTableView.isHidden = true
        }
    }
}


// MARK: Extension

extension UserSearchPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 셀 ID는 두 셀 모두 feedViewCell로 통일
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedViewCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == userTableView { return 95 }
        else if tableView == postTableView { return 400 }
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == postTableView {
            let detailVC = BookPostDetailVC()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.modalTransitionStyle = .coverVertical
            
            self.present(detailVC, animated: true)
        }
        
        if tableView == userTableView {
            let friendVC = FriendPageVC()
//            friendVC.modalPresentationStyle = .fullScreen
//            friendVC.modalTransitionStyle = .coverVertical
//
//            self.present(friendVC, animated: true)

            navigationController?.pushViewController(friendVC, animated: true)
        }
    }
}

//struct UserSearchPageVC_Preview: PreviewProvider {
//    static var previews: some View {
//        UserSearchPageVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}

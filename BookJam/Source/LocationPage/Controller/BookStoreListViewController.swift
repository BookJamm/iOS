//
//  BookStoreListViewController.swift
//  BookJam
//
//  Created by 박민서 on 12/8/23.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreListViewController: UIViewController {
    
    // MARK: Variables
    
    /// 테이블 뷰 위의 타이틀과 필터 버튼이 들어가는 헤더입니다.
    lazy var headerView: UIView = UIView().then {
        $0.backgroundColor = .white
        // 테이블 뷰의 header, footer엔 frame값이 필요합니다.
        $0.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 52)
    }
    
    /// 헤더의 타이틀 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "추천 장소"
        $0.font = title06
        $0.textColor = gray10
    }
    
    /// 평점순 버튼
    lazy var filterButton_rating = ColorToggleButton(title: "평점순")
    
    /// 리뷰순 버튼
    lazy var filterButton_review = ColorToggleButton(title: "리뷰순")
    
    /// 거리순 버튼
    lazy var filterButton_distance = ColorToggleButton(title: "거리순")
    
    /// 헤더의 필터 스택뷰입니다
    lazy var filterHStackView: UIStackView = UIStackView(arrangedSubviews: [
        filterButton_rating,
        filterButton_review,
        filterButton_distance
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    /// 바디의 테이블 뷰입니다
    lazy var locationTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorInset.left = 15
        $0.separatorInset.right = 15
        $0.separatorColor = gray04
    }
    
    /// 테이블 뷰 아래의 버튼이 들어가는 푸터입니다
    lazy var footerView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 52)
    }
    
    /// 푸터에 들어가는 메인 가는 버튼
    lazy var bottomBtn: UIButton = UIButton().then {
        $0.setTitle("더 많은 장소를 메인에서 확인하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = paragraph01
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 17, weight: .light, scale: .small)
        $0.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    
    // MARK: View
    func setUpView() {
        self.view.backgroundColor = .white
        self.locationTableView.tableFooterView = footerView
        self.locationTableView.register(BookStoreTableViewCell.self, forCellReuseIdentifier: BookStoreTableViewCell.cellID)
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            titleLabel,
            filterHStackView
        ].forEach { self.headerView.addSubview($0)}
        
        [
            bottomBtn
        ].forEach { self.footerView.addSubview($0)}
        
        [
            headerView,
            locationTableView
        ].forEach { self.view.addSubview($0) }
    }
    
    // MARK: Constraint
    func setUpConstraint() {
        // MARK: - header
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.equalToSuperview().offset(20)
            }
        
            filterHStackView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(20)
                $0.height.equalTo(28)
            }
        
        
        // MARK: - body tableView
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        bottomBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

//
//  LocationTableView.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/28.
//

import SwiftUI
import UIKit

import SnapKit
import Then

/// LocationPageVC에 사용하는 View입니다.
/// -   헤더 - 타이틀 + 필터 버튼
/// -   테이블 뷰 - 책방 목록
/// -   푸터 - 메인페이지가는 버튼
class BookStoreListView: UIView {
    
    // MARK: Variables
    
    /// 테이블 뷰 위의 타이틀과 필터 버튼이 들어가는 헤더입니다.
    lazy var headerView: UIView = UIView().then {
        $0.backgroundColor = .white
        // 테이블 뷰의 header, footer엔 frame값이 필요합니다.
        $0.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 52)
    }
    
    /// 헤더의 타이틀 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "title"
        $0.font = title06
        $0.textColor = gray10
    }
    
    /// 헤더의 필터 버튼
    lazy var filterBtn: UIButton = UIButton().then {
        $0.setTitle("인기순", for: .normal)
        $0.setTitleColor(gray05, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 17, weight: .light, scale: .small)
        $0.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
        
        $0.menu = UIMenu(children: [
            UIAction(title: "인기순", state: .on, handler: { _ in
                print("인기순")
            }),
            UIAction(title: "리뷰순", handler: { _ in
                print("리뷰순")
            }),
            UIAction(title: "평점순", handler: { _ in
                print("평점순")
            }),
        ])
        
        $0.showsMenuAsPrimaryAction = true
        $0.changesSelectionAsPrimaryAction = true
    }
    
    /// 바디의 테이블 뷰입니다
    lazy var locationTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    /// 테이블 뷰 아래의 버튼이 들어가는 푸터입니다
    lazy var footerView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 52)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .white
        self.locationTableView.tableHeaderView = headerView
        self.locationTableView.tableFooterView = footerView
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            titleLabel,
            filterBtn
        ].forEach { self.headerView.addSubview($0)}
        
        [
            bottomBtn
        ].forEach { self.footerView.addSubview($0)}
        
        [
//            headerView,
            locationTableView
//            footerView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        // MARK: - header
//        headerView.snp.makeConstraints {
//            $0.top.left.right.equalToSuperview()
//            $0.height.equalTo(60)
//        }
        
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalTo(filterBtn.snp.leading).offset(-10).priority(.low)
                $0.centerY.equalToSuperview()
            }
            
            filterBtn.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-30).priority(.high)
                $0.centerY.equalTo(titleLabel)
            }
        
        // MARK: - body tableView
        locationTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // MARK: - footer
//        footerView.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.height.equalTo(60)
//            $0.horizontalEdges.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
        
            bottomBtn.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        
        
        
    }
}

struct BookStoreListView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = BookStoreListView()
            return view
        }
        .previewLayout(.fixed(width: 393, height: 650))
//        .previewDevice("iPhone SE (3rd generation)")
    }
}

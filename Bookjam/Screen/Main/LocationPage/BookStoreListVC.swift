//
//  BookStoreListVC.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreListViewController: UIViewController {

    // MARK: Variables
    /// BookStoreVC에서 사용하는 서점 객체들의 모델 리스트입니다.
    /// Cell Data Fetching에 사용합니다.
    private var bookStoreList : [GetPlaceResponseModel]?

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: - LocationPageVC에서 서점 목록 불러왔을 때 본 VC의 테이블 뷰 업데이트
        NotificationCenter.default.addObserver(self, selector: #selector(handStoreList), name: NSNotification.Name("handStoreList") , object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    func enableTableViewScroll() {
        self.locationTableView.isScrollEnabled = true
    }
    

    // MARK: View
    func setUpView() {
        self.view.backgroundColor = .white
        self.locationTableView.tableFooterView = footerView
        self.locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        self.locationTableView.dataSource = self
        self.locationTableView.delegate = self
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
            headerView,
            locationTableView
//            footerView
        ].forEach { self.view.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        // MARK: - header
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
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
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
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
    
    // MARK: - LocationPageVC에서 API 작업 진행 후 넘어오는 noti
    @objc func handStoreList(_ sender: Notification) {
        if let storeList = sender.object as? [GetPlaceResponseModel] {
            self.bookStoreList = storeList
            self.locationTableView.reloadData()
        }
    }
}

// MARK: - TableView Extension
// MARK: - API연결시 변경해주어야 합니다
extension BookStoreListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
// MARK: - 셀 리스트 개수 반환
        if let count = bookStoreList?.count{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        
        // MARK: - 셀 내용 배정
        guard let storeList = self.bookStoreList else { return cell }
        cell.cellModel = storeList[indexPath.row]
        return cell
    }
            
    
    // MARK: - 테이블뷰 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//셀 클릭 시 해당 placeId api 불러오고 디테일뷰로 전환
        
        if let placeID = self.bookStoreList?[indexPath.row].placeId {
            NotificationCenter.default.post(name: NSNotification.Name("presentVC"), object: placeID)
        }
    }
    
    // MARK: - 테이블 뷰 스크롤 시
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.locationTableView {
            if scrollView.contentOffset.y < 0 {
                NotificationCenter.default.post(name: NSNotification.Name("PanelMove"), object: nil)
            }
        }
    }
}

struct BookStoreListViewController_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreListViewController().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

//
//  SeachEnterResultVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/13.
//

// MARK: - 검색 창에서 검색어를 입력하고 엔터를 누르면 이동하는 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class SearchEnterResultVC: UIViewController {

    // MARK: Variables
    
    var searchResultLabel: UILabel = UILabel().then {
        $0.text = "가게 검색 결과"
        $0.font = paragraph04
    }
    
    var numOfResultLabel: UILabel = UILabel().then {
        $0.text = "0"
        $0.font = paragraph04
        $0.textColor = main03
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var menuButton: UIButton = UIButton().then {
        $0.setTitle("거리순", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(gray07, for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
        
        /// 타이틀과 이미지 사이 간격 부여
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.down")
        config.buttonSize = .small
        config.imagePadding = 4
        $0.configuration = config
        
        /// 터치했을 때 나오는 메뉴 선언
        $0.menu = UIMenu(children: [
            UIAction(title: "거리순", state: .on, handler: { _ in print("거리순")}),
            UIAction(title: "리뷰순", handler: { _ in print("리뷰순")}),
            UIAction(title: "평점순", handler: { _ in print("평점순")}),
        ])
        /// 터치하면 바로 메뉴 나오도록 설정
        $0.showsMenuAsPrimaryAction = true
        /// 체크 표시 하나만 할 수 있도록 설정
        $0.changesSelectionAsPrimaryAction = true
    }
    
    var resultTableView: UITableView = UITableView().then {
        $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.cellID)
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
            searchResultLabel,
            numOfResultLabel,
            underLineView,
            menuButton,
            resultTableView
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        searchResultLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        numOfResultLabel.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel)
            $0.leading.equalTo(searchResultLabel.snp.trailing).offset(5)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(numOfResultLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.7)
        }
        
        menuButton.snp.makeConstraints {
            $0.centerY.equalTo(numOfResultLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        resultTableView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: Extension

extension SearchEnterResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellID, for: indexPath) as! SearchResultTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultVC = BookstoreDetailPageVC()
        
        // TODO: 데이터 연결
        
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

struct SearchEnterResultVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchEnterResultVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

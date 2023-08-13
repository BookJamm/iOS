//
//  SearchPageVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/13.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class SearchPageVC: UIViewController {

    // MARK: Variables
    
    var searchBar: UISearchBar = UISearchBar().then {
        $0.placeholder = "상호명 또는 주소 검색"
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        $0.layer.borderColor = main02?.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
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
        
        hideKeyboard()
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            searchBar,
            searchResultLabel,
            numOfResultLabel,
            underLineView,
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
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        searchResultLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar).offset(10)
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
        
        resultTableView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: Extension

extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
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

struct SearchPageVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

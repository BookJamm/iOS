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
    
    var searchResult: [KeywordSearchResponseModel]?
    
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
        
        searchBar.delegate = self
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
            $0.centerY.equalTo(searchResultLabel)
            $0.leading.equalTo(searchResultLabel.snp.trailing).offset(5)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(numOfResultLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.7)
        }
        
        resultTableView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Func
    
    func updateTable(with results: [KeywordSearchResponseModel]) {
    
        searchResult = results
        
        resultTableView.reloadData()
    }
}


// MARK: Extension

extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // TODO: 검색 값 불러오는 서버 api 연결
        
        guard !searchText.isEmpty else {
            updateTable(with: [])
            return
        }
        
        let requestModel = KeywordSearchRequestModel(keyword: searchText, sortBy: "distance", lat: 37.270225, lon: 127.048789)
        //임시 위경도
        
        APIManager.shared.getData(
            urlEndpointString: Constant.keywordSearch,
            responseDataType: APIModel<[KeywordSearchResponseModel]>?.self,
            requestDataType: KeywordSearchRequestModel.self,
            parameter: requestModel,
            completionHandler: { [weak self] response in
                guard let self = self, let results = response?.result else { return }
                
                DispatchQueue.main.async {
                    self.updateTable(with: results)
                    self.numOfResultLabel.text = String(results.count)
                }
            })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchEnterResultVC = SearchEnterResultVC()
        
        searchEnterResultVC.searchResults = self.searchResult
        
        navigationController?.pushViewController(searchEnterResultVC, animated: true)
    }
}

extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellID, for: indexPath) as! SearchResultTableViewCell
        
        if let searchResult = searchResult, indexPath.row < searchResult.count {
            let result = searchResult[indexPath.row]
            
            cell.storeNameLabel.text = result.name
            cell.locationLabel.text = result.address?.road
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 클릭됨")
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

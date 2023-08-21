//
//  SearchBookPopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import SwiftUI
import UIKit

import Kingfisher
import SnapKit
import Then


class SearchBookPopUpVC: UIViewController {
    
    // MARK: Variables
    
    /// 화면 여백을 클릭했을 때 팝업창 dismiss를 위한 view 선언
    var outsideView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    /// 책 검색했을 때 받을 결과 저장할 배열 선언
    var books: [BooksListResponseModel] = []
    
    var searchView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    var searchBarBackgroundView: UIView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = gray05?.cgColor
        $0.layer.borderWidth = 1
    }
    
    var searchTextField: UITextField = UITextField().then {
        $0.font = paragraph02
    }
    
    var searchButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = gray07
        $0.addTarget(self, action: #selector(didBookNameSearchButtonTapped), for: .touchUpInside)
    }
    
    var resultLabel: UILabel = UILabel().then {
        $0.text = "nn개의 검색결과"
        $0.font = paragraph01
        $0.isHidden = true
    }
    
    var resultTableView: UITableView = UITableView().then {
        $0.register(BookSearchTableViewCell.self, forCellReuseIdentifier: BookSearchTableViewCell().cellID)
        $0.isHidden = true
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
        view.backgroundColor = .clear
        
        resultTableView.separatorStyle = .none
    }
    
    /// 뒷쪽 뷰 클릭하면 화면 dismiss되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(outsideView)
        view.addSubview(searchView)
        [
            searchBarBackgroundView,
            searchTextField,
            searchButton,
            resultLabel,
            resultTableView
        ].forEach { searchView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        outsideView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(500)
        }
        
        searchBarBackgroundView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalTo(searchBarBackgroundView)
            $0.leading.equalTo(searchBarBackgroundView).offset(20)
            $0.trailing.equalTo(searchBarBackgroundView).offset(-50)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(searchBarBackgroundView)
            $0.trailing.equalTo(searchBarBackgroundView).offset(-15)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(searchBarBackgroundView.snp.bottom).offset(20)
            $0.leading.equalTo(searchBarBackgroundView).offset(10)
        }
        
        resultTableView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.bottom.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    
    // MARK: Function
    
    /// 검색 버튼 눌렀을 때 텍스트필드 값 바탕으로 검색해서 테이블뷰 결과 로드
    @objc func didBookNameSearchButtonTapped() {
        print("검색 버튼 눌림")
        if let searchKeyword = searchTextField.text,
           let encodedKeyword = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            APIManager.shared.getData(
                urlEndpointString: Constant.getBooksList(title: encodedKeyword),
                responseDataType: APIModel<[BooksListResponseModel]>?.self,
                requestDataType: BooksListRequestModel.self,
                parameter: nil) { response in
                    self.books = response?.result ?? []
                    
                    self.resultTableView.reloadData()
                    self.resultLabel.text = "\(self.books.count) search results"
                    self.resultLabel.isHidden = false
                    self.resultTableView.isHidden = false
                }
        }
    }
}


// MARK: Extension

extension SearchBookPopUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookSearchTableViewCell().cellID, for: indexPath) as! BookSearchTableViewCell
        
        cell.bookImageView.kf.setImage(with: URL(string: books[indexPath.row].cover!), placeholder: UIImage(named: "emptyBook"))
        cell.bookNameLabel.text = books[indexPath.row].title
        cell.authorLabel.text = books[indexPath.row].author
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    /// 셀 누르면 해당 셀 데이터 notification 보내고 화면 dismiss
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didBookSearchCellTapped"), object: books[indexPath.row])
        
        self.dismiss(animated: true)
    }
}

struct SearchBookPopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchBookPopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

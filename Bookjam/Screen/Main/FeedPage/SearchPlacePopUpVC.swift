//
//  SearchPlacePopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/15.
//

import SwiftUI
import UIKit
import WebKit

import SnapKit
import Then


class SearchPlacePopUpVC: UIViewController, WKUIDelegate {
    
    // MARK: Variables
    
    /// 주소찾기 API에서 반환받은 도로명 주소를 저장할 변수 선언
    var address = ""
    
    var searchView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    var searchPlaceWebView: WKWebView = WKWebView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    var searchButton: UIButton = UIButton().then {
        $0.setTitle("주소 검색 결과", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = gray05?.cgColor
        $0.layer.borderWidth = 1
        $0.isHidden = true
    }
    
    var magnifyingGlassImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = gray07
        $0.isHidden = true
    }
    
    var numOfResultLabel: UILabel = UILabel().then {
        $0.font = paragraph01
        $0.text = "nn개의 검색결과"
        $0.isHidden = true
    }
    
    var searchResultTableView: UITableView = UITableView().then {
        $0.register(PlaceSearchTableViewCell.self, forCellReuseIdentifier: PlaceSearchTableViewCell().cellID)
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
        setUpWebView()
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(searchView)
        [
            searchPlaceWebView,
            searchButton,
            magnifyingGlassImageView,
            numOfResultLabel,
            searchResultTableView
        ].forEach { searchView.addSubview($0) }
        
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        searchPlaceWebView.uiDelegate = self
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        searchView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(350)
            $0.height.equalTo(500)
        }
        
        searchPlaceWebView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        magnifyingGlassImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchButton)
            $0.trailing.equalToSuperview().offset(25)
        }
        
        numOfResultLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(10)
            $0.leading.equalTo(searchButton).offset(10)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(numOfResultLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    
    // MARK: Function
    
    private func setUpWebView() {
        searchPlaceWebView = WKWebView(frame: .zero,
                                       configuration: WKWebViewConfiguration().then {
            $0.userContentController = WKUserContentController().then {
                $0.add(self, name: "callBackHandler")
            }
        })
        
        /// 깃허브에 미리 세팅해둔 주소찾기 웹페이지 로드
        searchPlaceWebView.load(URLRequest(url: URL(string: "https://bookjamm.github.io/SearchPlace/")!))
    }
}


// MARK: Extension

extension SearchPlacePopUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceSearchTableViewCell().cellID, for: indexPath)
        
        return cell
    }
    
    /// 셀 선택되면 창 닫히고 FeedPostPageVC에서 장소 탭 업데이트되도록 설정
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("셀 선택됨")
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "feedPlaceSearchResultCellTapped")))
    
        self.dismiss(animated: true)
    }
    
}

extension SearchPlacePopUpVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }
        
        print(address)
        
        /// 주소찾기 끝나면 결과 화면 나오게 설정
        // TODO: 데이터 연결
        
        searchButton.setTitle("\(address)", for: .normal)
        // numOfResultLabel.text = "\()개의 검색결과"
        
        searchPlaceWebView.isHidden = true
        [
            searchButton,
            magnifyingGlassImageView,
            numOfResultLabel,
            searchResultTableView
        ].forEach { $0.isHidden = false }
    }
}

struct SearchPlacePopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchPlacePopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

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
    
    var searchView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    var searchPlaceWebView: WKWebView = WKWebView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    let indicator = UIActivityIndicatorView(style: .medium)
    
    var address = ""
    
    let contentController = WKUserContentController()
    
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
        searchView.addSubview(searchPlaceWebView)
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        searchPlaceWebView.uiDelegate = self
        searchPlaceWebView.navigationDelegate = self
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
    }
    
    
    // MARK: Function
    
    private func setUpWebView() {
        let contentController = WKUserContentController().then {
            $0.add(self, name: "callBackHandler")
        }
        
        let configuration = WKWebViewConfiguration().then {
            $0.userContentController = contentController
        }
        
        ///
        searchPlaceWebView = WKWebView(frame: .zero, configuration: configuration)
        
        /// 깃허브에 미리 세팅해둔 주소찾기 웹페이지 로드
        searchPlaceWebView.load(URLRequest(url: URL(string: "https://bookjamm.github.io/SearchPlace/")!))
        
        indicator.startAnimating()
    }
}


// MARK: Extension

extension SearchPlacePopUpVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }
        
        print(address)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchPlacePopUpVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

struct SearchPlacePopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchPlacePopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

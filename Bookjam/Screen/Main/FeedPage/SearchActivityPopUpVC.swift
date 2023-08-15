//
//  SearchActivityPopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class SearchActivityPopUpVC: UIViewController {

    // MARK: Variables
    
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
        $0.addTarget(self, action: #selector(didActivityNameSearchButtonTapped), for: .touchUpInside)
    }
    
    var resultLabel: UILabel = UILabel().then {
        $0.text = "nn개의 검색결과"
        $0.font = paragraph01
        $0.isHidden = true
    }
    
    // TODO: 활동 셀 디자인 완료되면 register해서 구현
    var resultTableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
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
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
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
        }
    }
    
    
    // MARK: Function
    
    /// 검색 버튼 눌렀을 때 텍스트필드 값 바탕으로 검색해서 테이블뷰 결과 로드
    @objc func didActivityNameSearchButtonTapped() {
        let searchKeyword = searchTextField.text
        
        resultLabel.isHidden = false
    }
}

struct SearchActivityPopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SearchActivityPopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

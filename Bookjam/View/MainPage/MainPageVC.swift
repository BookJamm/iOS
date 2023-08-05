//
//  MainPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class MainPageVC: UIViewController {

    // MARK: Variables
    
    var searchBar: UISearchBar = UISearchBar().then{
        $0.placeholder = "상호명 또는 주소 검색"
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        $0.layer.borderColor = main02?.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
    var independentBookstoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
        $0.tintColor = main03
        $0.titleLabel?.font = paragraph02
        
        //이미지 크기 쉽게 조절
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "book.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration
        $0.configuration = configuration
    }
    
    var bookPlayGroundButton: UIButton = UIButton().then{
        $0.setTitle("책 놀이터", for: .normal)
        $0.tintColor = gray05
        $0.titleLabel?.font = paragraph02
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "cup.and.saucer.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
        $0.tintColor = gray05
        $0.titleLabel?.font = paragraph02
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "books.vertical.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var sortView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var lineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var sortButton: UIButton = UIButton().then{
        $0.setTitle("거리순 ↓", for: .normal)
        $0.setTitleColor(gray05, for: .normal)
        $0.setTitle("거리순", for: .selected)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    var infoButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
        $0.tintColor = gray05
    }
    
    var tableView: UITableView = UITableView().then {
//        $0.backgroundColor = .blue  //테스트 확인용 임시 색상
        $0.register(MainPageBookStoreTableViewCell.self, forCellReuseIdentifier: "bookStoreCell")
    }
    
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        
        // hideKeyboard()
    }

    // MARK: Layout
    
    func setUpLayout(){
        [
            searchBar,
            independentBookstoreButton,
            bookPlayGroundButton,
            libraryButton,
            tableView,
            sortView
        ].forEach {
            view.addSubview($0)
        }
        sortView.addSubview(lineView)
        sortView.addSubview(sortButton)
        sortView.addSubview(infoButton)
    }
    
    // MARK: Constraints

    func setUpConstraint(){
        searchBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        independentBookstoreButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        
        bookPlayGroundButton.snp.makeConstraints {
            $0.centerY.equalTo(independentBookstoreButton)
            $0.centerX.equalToSuperview()
        }
        
        libraryButton.snp.makeConstraints {
            $0.centerY.equalTo(independentBookstoreButton)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        sortView.snp.makeConstraints {
            $0.top.equalTo(independentBookstoreButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(sortButton)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }//end of setUpConstraint
    
    // MARK: Delegate
    
    func setUpDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}//end of MainPageVC

// MARK: Extension

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookStoreCell", for: indexPath) as! MainPageBookStoreTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = BookstoreDetailVC()
        
        // TODO: 데이터 넣기
        
        navigationController?.pushViewController(detailPage, animated: true)
    }
}

extension UIImage {
    // Create a UIImage with a solid color
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

struct MainPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MainPageVC().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}

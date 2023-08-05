//
//  BookStoreDetailNewsView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailNewsView: UIView {

    // MARK: Variables
    
    var bookStoreName = "bookstore_name"
    
    var newsList: [News] = [
        News(storePhoto: "squareDefaultImage", title: "연휴 휴무 안내", content: "이번 연휴 기간동안 휴무입니다 :) 좋은 연휴 보내세요", date: "2023. 06. 28", photo: ""),
        News(storePhoto: "squareDefaultImage", title: "연휴 휴무 안내", content: "이번 연휴 기간동안 휴무입니다 :) 좋은 연휴 보내세요", date: "2023. 06. 28", photo: ""),
        News(storePhoto: "squareDefaultImage", title: "연휴 휴무 안내", content: "이번 연휴 기간동안 휴무입니다 :) 좋은 연휴 보내세요", date: "2023. 06. 28", photo: "")
    ]
    
    var bookPlaceLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책방 이름의 소식"
    }
    
    var newsTableView: UITableView = UITableView().then {
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        newsTableView.isScrollEnabled = false
        newsTableView.separatorStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookPlaceLabel,
            newsTableView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookPlaceLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(30)
        }
        
        newsTableView.snp.makeConstraints {
            $0.top.equalTo(bookPlaceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension BookStoreDetailNewsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.profileImageView.image = UIImage(named: newsList[indexPath.row].storePhoto)?.circularImage()
        cell.newsLabel.text = newsList[indexPath.row].title
        cell.newsContent.text = newsList[indexPath.row].content
        cell.newsDate.text = newsList[indexPath.row].date
        
        return cell
    }
    
    // 글 길이에 맞게 뷰 높이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if newsList[indexPath.row].content.count < 30 { return 100 }
        else if newsList[indexPath.row].content.count >= 18 && newsList[indexPath.row].content.count < 36 { return 150 }
        else if newsList[indexPath.row].content.count >= 30 && newsList[indexPath.row].content.count < 36 { return 200 }
        else { return 300 }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailNewsView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailNewsView()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

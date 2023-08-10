//
//  BookStoreDetailBookTypeView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 페이지 책 종류 탭 구현

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailBookListView: UIView {

    // MARK: Variables
    
    // 책 데이터 삽입을 위한 Book 배열 선언
    var bookList: [Book] = [
        Book(title: "기후변화 시대의 사랑", author: "김기창", publisher: "민음사", content: "폭우, 폭염, 혹한, 백화, 해빙 등 기후 변화를 배경으로 한 다양한 사랑 소설집", photo: "chaekYeonBook1"),
        Book(title: "돈과 나의 일", author: "이원지", publisher: "독립출판물", content: "일하며 살아가는 마음, 우리가 이루고 싶은 꿈과 완성하고 싶은 삶의 태도에 관한 이야기", photo: "chaekYeonBook2"),
        Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "환상적 욕망과 가난한 현실 사이 달콤한 선택지.", photo: "tempBookImage")
    ]
    
    var bookListLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책 종류"
    }
    
    var bookListTableView: UITableView = UITableView().then {
        $0.register(BookListTableViewCell.self, forCellReuseIdentifier: "bookListCell")
    }

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        bookListTableView.isScrollEnabled = false
        bookListTableView.separatorStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookListLabel,
            bookListTableView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        bookListTableView.dataSource = self
        bookListTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookListTableView.snp.makeConstraints {
            $0.top.equalTo(bookListLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().offset(10)
        }
    }
}

// 책 종류 탭 TableView 셀 삽입을 위한 Delegate와 DataSource 구현
extension BookStoreDetailBookListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    // 셀 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookListTableView.dequeueReusableCell(withIdentifier: "bookListCell", for: indexPath) as! BookListTableViewCell
        
        cell.titleLabel.text = bookList[indexPath.row].title
        cell.authorLabel.text = bookList[indexPath.row].author
        cell.publisherLabel.text = bookList[indexPath.row].publisher
        cell.bookImageView.image = UIImage(named: bookList[indexPath.row].photo)
        cell.contentLabel.text = bookList[indexPath.row].content
        
        return cell
    }
    
    // 높이 220으로 고정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailBookListView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailBookListView()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  BookStoreDetailBookTypeView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailBookListView: UIView {

    // MARK: Variables
    
    var bookList: [Book] = [
        Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "", photo: ""),
        Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "", photo: ""),
        Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "", photo: "")
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

extension BookStoreDetailBookListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookListTableView.dequeueReusableCell(withIdentifier: "bookListCell", for: indexPath) as! BookListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
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

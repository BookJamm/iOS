//
//  BookListTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/01.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class BookListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    
    // MARK: Variable
    
    static let cellID =  "bookListCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 0, height: 7)
        $0.layer.shadowRadius = 3
        $0.layer.masksToBounds = false
        $0.image = UIImage(named: "tempBookImage")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
        $0.text = "책 이름"
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "작가 이름"
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "출판사 이름"
    }
    
    var contentLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "책에 대한 설명입니다. 책에 대한 설명입니다. 책에 대한 설명입니다. 책에 대한 설명입니다. 책에 대한 설명입니다."
        $0.numberOfLines = 5
    }
    
    // MARK: View
    
    func setUpView() {

    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookImageView,
            titleLabel,
            authorLabel,
            publisherLabel,
            contentLabel
        ].forEach { self.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(200)
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(40)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.centerY.equalTo(authorLabel)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(5)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(authorLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct BookListTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = BookListTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

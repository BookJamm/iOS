//
//  BookSearchTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookSearchTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = "bookSearchCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "emptyBook")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    var bookNameLabel: UILabel = UILabel().then {
        $0.text = "책 이름"
        $0.font = paragraph02
        $0.numberOfLines = 2
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.text = "작가 이름"
        $0.font = captionText02
        $0.textColor = gray06
        $0.numberOfLines = 3
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.text = "출판사 이름"
        $0.font = captionText02
        $0.textColor = gray06
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookImageView,
            bookNameLabel,
            authorLabel,
            publisherLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(200)
            $0.width.equalTo(120)
        }
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView).offset(30)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(bookNameLabel)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        // TODO: 서버 api 수정되면 연결
//        publisherLabel.snp.makeConstraints {
//            $0.centerY.equalTo(authorLabel)
//            $0.leading.equalTo(authorLabel.snp.trailing).offset(10)
//        }
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct BookSearchTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = BookSearchTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

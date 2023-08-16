//
//  PlaceSearchTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class PlaceSearchTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = "placeSearchCell"
    
    var bookStoreImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.contentMode = .scaleAspectFill
    }
    
    var bookStoreLabel: UILabel = UILabel().then {
        $0.text = "책방 이름"
        $0.font = title06
    }
    
    var bookStoreTypeImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var bookStoreAddressLabel: UILabel = UILabel().then {
        $0.text = "책방주소책방주소책방주소책방주소책방주소책방주소책방주소"
        $0.font = paragraph03
        $0.textColor = gray06
        $0.numberOfLines = 2
    }
    
    var bookStoreStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var bookStoreRatingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var bookStoreNumOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
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
            bookStoreImageView,
            bookStoreLabel,
            bookStoreTypeImageView,
            bookStoreAddressLabel,
            bookStoreStarImageView,
            bookStoreRatingLabel,
            bookStoreNumOfReviewLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookStoreImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(120)
        }
        
        bookStoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(bookStoreImageView.snp.trailing).offset(20)
        }
        
        bookStoreTypeImageView.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreLabel)
            $0.leading.equalTo(bookStoreLabel.snp.trailing).offset(5)
        }
        
        bookStoreAddressLabel.snp.makeConstraints {
            $0.top.equalTo(bookStoreLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreLabel)
            $0.trailing.equalToSuperview()
        }
        
        bookStoreStarImageView.snp.makeConstraints {
            $0.top.equalTo(bookStoreAddressLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreAddressLabel)
        }
        
        bookStoreRatingLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreStarImageView)
            $0.leading.equalTo(bookStoreStarImageView.snp.trailing).offset(5)
        }
        
        bookStoreNumOfReviewLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreStarImageView)
            $0.leading.equalTo(bookStoreRatingLabel.snp.trailing).offset(5)
        }
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct PlaceSearchTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = PlaceSearchTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  ReviewTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class ReviewTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = "feedReviewCell"
    
    var userProfileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")!.circularImage()
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = .black
        $0.text = "유저 이름"
    }

    var userVisitDateLabel: UILabel = UILabel().then {
        $0.font = captionText03
        $0.textColor = .black
        $0.text = "YYYY / MM / DD 방문"
    }

    var commentLabel: UILabel = UILabel().then {
        $0.font = paragraph06
        $0.textColor = .black
        $0.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        $0.numberOfLines = 50
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
            userProfileImageView,
            userNameLabel,
            userVisitDateLabel,
            commentLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        userProfileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(60)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(userProfileImageView.snp.centerY).offset(-5)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(20)
        }
        
        userVisitDateLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.centerY).offset(5)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct ReviewTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ReviewTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  VisitReviewTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/03.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class VisitReviewTableViewCell: UITableViewCell {
    
    // MARK: Variable
    
    static let cellID =  "visitReviewCell"
    
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

    var addFriendButton: UIButton = UIButton().then {
        $0.setTitle("   친구 추가   ", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.backgroundColor = main03?.cgColor
        $0.titleLabel?.font = captionText01
        $0.addTarget(self, action: #selector(didAddFriendButtonTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 14
    }

    var commentLabel: UILabel = UILabel().then {
        $0.font = paragraph06
        $0.textColor = .black
        $0.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        $0.numberOfLines = 2
    }

    var imageStackView: UIStackView = UIStackView().then {
        $0.spacing = 1
    }

    var firstImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
    }

    var secondImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
    }

    var thirdImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
    }

    var fourthImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .clear
        self.contentMode = .scaleAspectFit
        
        imageStackView.spacing = 2
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            userProfileImageView,
            userNameLabel,
            userVisitDateLabel,
            addFriendButton,
            commentLabel,
            imageStackView
        ].forEach { self.addSubview($0) }
        
        [
            firstImage,
            secondImage,
            thirdImage,
            fourthImage
        ].forEach { imageStackView.addArrangedSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        userProfileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(60)
        }

        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(10)
        }

        userVisitDateLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(userNameLabel.snp.leading)
        }

        addFriendButton.snp.makeConstraints {
            $0.centerY.equalTo(userProfileImageView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }

        commentLabel.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40)
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(20)
            $0.leading.equalTo(userProfileImageView.snp.leading)
        }

        imageStackView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        firstImage.snp.makeConstraints {
            $0.height.width.equalTo(commentLabel.snp.width).dividedBy(4).offset(-1)
        }
        
        secondImage.snp.makeConstraints {
            $0.height.width.equalTo(commentLabel.snp.width).dividedBy(4).offset(-1)
        }

        thirdImage.snp.makeConstraints {
            $0.height.width.equalTo(commentLabel.snp.width).dividedBy(4).offset(-1)
        }

        fourthImage.snp.makeConstraints {
            $0.height.width.equalTo(commentLabel.snp.width).dividedBy(4).offset(-1)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didAddFriendButtonTapped() {
        
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct VisitReviewTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = VisitReviewTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

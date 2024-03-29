//
//  BookReviewCollectionViewCell.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit

class BookReviewCollectionViewCell: UICollectionViewCell {
    // MARK: Variable
    
    static let id =  "visitReviewCell"
    
    var userProfileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")!
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = .black
        $0.text = "유저 이름"
        $0.sizeToFit()
    }

    var userVisitDateLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = .black
        $0.text = "YYYY / MM / DD 방문"
        $0.sizeToFit()
    }

    var addFriendButton: UIButton = UIButton().then {
        $0.setTitle("   친구 추가   ", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.backgroundColor = main03?.cgColor
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 14
    }

    var commentLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = .black
        $0.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        $0.numberOfLines = 20
        $0.sizeToFit()
    }

    var imageStackView: UIStackView = UIStackView().then {
        $0.spacing = 1
    }

    var firstImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        
        $0.clipsToBounds = true
    }

    var secondImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }

    var thirdImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }

    var fourthImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            $0.trailing.equalToSuperview().offset(-20)
        }

        imageStackView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
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
    
    func configure(name: String, contents: String, visitedAt: String) {
        userNameLabel.text = name
        commentLabel.text = contents
        userVisitDateLabel.text = visitedAt + " 방문"
    }
}

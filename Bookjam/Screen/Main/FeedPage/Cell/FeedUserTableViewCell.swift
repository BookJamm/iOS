//
//  FeedUserTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class FeedUserTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = "feedViewCell"
    
    var isFriend: Bool = false
    
    var profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.text = "user name"
        $0.font = title06
    }
    
    var isFollowLabel: UILabel = UILabel().then {
        $0.text = "팔로우 중입니다."
        $0.font = captionText02
        $0.textColor = gray06
    }
    
    var addFriendButton: UIButton = UIButton().then {
        $0.setTitle("친구 추가", for: .normal)
        $0.titleLabel?.font = captionText01
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = main03
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(didAddFeedFriendButtonTapped), for: .touchUpInside)
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
        if isFriend == true {
            isFollowLabel.isHidden = false
            addFriendButton.isHidden = true
        }
        else {
            isFollowLabel.isHidden = true
            addFriendButton.isHidden = false
        }
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            userNameLabel,
            isFollowLabel,
            addFriendButton
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(60)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        isFollowLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(5)
            $0.leading.equalTo(userNameLabel)
        }
        
        addFriendButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
    }
    
    
    // MARK: Function
    
    @objc func didAddFeedFriendButtonTapped() {
        isFriend = true
        
        isFollowLabel.isHidden = false
        addFriendButton.isHidden = true
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct FeedUserTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = FeedUserTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

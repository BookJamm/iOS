//
//  FriendInfoTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/23.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class FriendInfoTableViewCell: UITableViewCell {

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
    
    let cellID =  "friendInfoCell"
    
    var isFriend: Bool = false
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
        $0.contentMode = .scaleAspectFill
    }
    
    let nicknameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "BOOKJAM"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.sizeToFit()
    }
    
    let emailLabel: UILabel = UILabel().then {
        $0.textColor = UIColor(hexCode: "A5A5A5")
        $0.textAlignment = .left
        $0.text = "bookjam@gmail.com"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.sizeToFit()
    }
    
    let addFriendButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "addButton"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didFriendButtonTapped), for: .touchUpInside)
    }
    

    // MARK: View
    
    func setUpView() {
        self.contentMode = .scaleAspectFit
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            nicknameLabel,
            emailLabel,
            addFriendButton
        ].forEach { self.contentView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(profileImageView.snp.centerY).offset(5)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        addFriendButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.right.equalToSuperview().multipliedBy(0.98)
            
        }
    }
    
    
    // MARK: Functions
    
    // 추가 버튼 누르면 isFriend 상태가 toggle되고 이미지 상태도 같이 토글되도록 구현
    // addFriendButton에 addTarget으로 연결됨
    @objc func didFriendButtonTapped() {
        isFriend.toggle()
        if isFriend == true { addFriendButton.setImage(UIImage(named: "removeButton"), for: .normal) }
        else { addFriendButton.setImage(UIImage(named: "addButton"), for: .normal) }
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct FriendInfoTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = FriendInfoTableViewCell()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

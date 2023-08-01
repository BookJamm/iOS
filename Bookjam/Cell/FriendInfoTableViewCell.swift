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
    
    static let cellID =  "friendInfoCell"
    
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
    }
    

    // MARK: View
    
    func setUpView() {
        self.backgroundColor = UIColor(hexCode: "F5F4F3")
        self.contentMode = .scaleAspectFit
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            nicknameLabel,
            emailLabel,
            addFriendButton
        ].forEach { self.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        profileImageView.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(30)
            $0.right.equalToSuperview().multipliedBy(0.8)
            $0.top.equalTo(profileImageView).offset(5)
        }
        
        emailLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(30)
            $0.right.equalToSuperview().multipliedBy(0.8)
            $0.top.equalTo(nicknameLabel).offset(30)
        }
        
        addFriendButton.snp.makeConstraints {
            $0.right.equalToSuperview().multipliedBy(0.98)
            $0.top.equalTo(nicknameLabel).offset(8)
        }
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

//
//  FeedBookTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class FeedBookTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = "feedBookCell"
    
    var profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.text = "user name"
        $0.font = title06
    }
    
    var timeLabel: UILabel = UILabel().then {
        $0.text = "2023 / 06 / 06 14:22"
        $0.font = captionText03
    }
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.itemSize = CGSize(width: 100, height: 100)
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    var contextLabel: UILabel = UILabel().then {
        $0.text = "유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다."
        $0.numberOfLines = 4
        $0.font = paragraph06
    }
    
    var moreButton: UIButton = UIButton().then {
        $0.setTitle("더보기 ", for: .normal)
        $0.titleLabel?.font = captionText02
        $0.setTitleColor(gray07, for: .normal)
        $0.setImage(UIImage(
            systemName: "chevron.down",
            withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 17, weight: .light, scale: .small)),
                    for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    var bookNameButton: UIButton = UIButton().then {
        $0.setTitle("책 이름입니다.", for: .normal)
        $0.setTitleColor(gray05, for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.borderColor = gray04?.cgColor
        $0.layer.borderWidth = 0.7
    }
    
    var commentImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 14, weight: .light, scale: .default))
        $0.tintColor = .black
    }
    
    var commentLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "nnn"
    }
    
    var heartImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 14, weight: .light, scale: .default))
        $0.tintColor = .black
    }
    
    var heartLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "nnn"
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
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            userNameLabel,
            timeLabel,
            photoCollectionView,
            contextLabel,
            moreButton,
            bookNameButton,
            commentImageView,
            commentLabel,
            heartImageView,
            heartLabel
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
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(5)
            $0.leading.equalTo(userNameLabel)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(150)
        }
        
        contextLabel.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(contextLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookNameButton.snp.makeConstraints {
            $0.top.equalTo(moreButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(110)
        }
        
        commentImageView.snp.makeConstraints {
            $0.top.equalTo(bookNameButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImageView)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(5)
        }
        
        heartImageView.snp.makeConstraints {
            $0.centerY.equalTo(commentImageView)
            $0.leading.equalTo(commentLabel.snp.trailing).offset(10)
        }
        
        heartLabel.snp.makeConstraints {
            $0.centerY.equalTo(heartImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}


// MARK: Extension

extension FeedBookTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookStorePhotoCell", for: indexPath) as! BookStorePhotoCollectionViewCell
        
        // images 데이터 cell에 할당
        // cell.photoImageView.image = UIImage(named: images[indexPath.row])
        cell.photoImageView.layer.cornerRadius = 8
        
        return cell
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct FeedBookTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = FeedBookTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  BookPostDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookPostDetailVC: UIViewController {

    // MARK: Variables
    
    var customNavigationView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var scrollView: UIScrollView = UIScrollView()
    
    var contentView: UIView = UIView()
    
    var postView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didCustomBackButtonTapped), for: .touchUpInside)
    }
    
    var postNameLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "user님의 게시글"
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    var userNameLabel: UILabel = UILabel().then {
        $0.text = "user name"
        $0.font = paragraph01
    }
    
    var timeLabel: UILabel = UILabel().then {
        $0.text = "2023 / 06 / 06 14:22"
        $0.font = captionText03
    }
    
    // TODO: 데모데이 끝나고는 스크롤 안되는 문제 해결해야 함
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    var contextLabel: UILabel = UILabel().then {
        $0.text = "유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다. 유저 독후감입니다."
        $0.numberOfLines = 100
        $0.font = paragraph06
    }
    
    var bookNameButton: UIButton = UIButton().then {
        $0.setTitle("  책 이름입니다.  ", for: .normal)
        $0.setTitleColor(gray05, for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.borderColor = gray04?.cgColor
        $0.layer.borderWidth = 0.7
    }
    
    var heartImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 19, weight: .light, scale: .default))
        $0.tintColor = .black
    }
    
    var heartLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "nnn"
    }

    var commentView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var commentImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "message.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 19, weight: .light, scale: .default))
        $0.tintColor = main03
    }
    
    var commentLabel: UILabel = UILabel().then {
        $0.font = paragraph01
        $0.text = "213개의 댓글"
    }
    
    var commentTableView: UITableView = UITableView().then {
        $0.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell().cellID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = gray02
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            customNavigationView,
            scrollView
        ].forEach { view.addSubview($0) }
        
        [
            backButton,
            postNameLabel,
            underLineView
        ].forEach { customNavigationView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        [
            postView,
            commentView
        ].forEach { contentView.addSubview($0) }
        
        [
            profileImageView,
            userNameLabel,
            timeLabel,
            photoCollectionView,
            contextLabel,
            bookNameButton,
            heartImageView,
            heartLabel
        ].forEach { postView.addSubview($0) }
        
        [
            commentImageView,
            commentLabel,
            commentTableView
        ].forEach { commentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        customNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        postNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(10)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        postView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(350)
        }
        
        contextLabel.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        bookNameButton.snp.makeConstraints {
            $0.top.equalTo(contextLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        heartImageView.snp.makeConstraints {
            $0.top.equalTo(bookNameButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        heartLabel.snp.makeConstraints {
            $0.centerY.equalTo(heartImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        commentView.snp.makeConstraints {
            $0.top.equalTo(postView.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        commentImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImageView)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(10)
        }
        
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(commentImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(500)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: Function
    
    @objc func didCustomBackButtonTapped() {
        
    }
}


// MARK: Extension

extension BookPostDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookStorePhotoCell", for: indexPath) as! BookStorePhotoCollectionViewCell
        
        // images 데이터 cell에 할당
        // cell.photoImageView.image = UIImage(named: images[indexPath.row])
        cell.photoImageView.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCollectionView.frame.height, height: photoCollectionView.frame.height)
    }
}

extension BookPostDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell().cellID, for: indexPath) as! ReviewTableViewCell
        
        return cell
    }
}

struct BookPostDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookPostDetailVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

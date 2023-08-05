//
//  MainPageBookStoreTableViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/02.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class MainPageBookStoreTableViewCell: UITableViewCell {
    
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
    
    
    // MARK: Variable
    
    static let cellID = "bookStoreCell"
    
    var images: [String] = ["squareDefaultImage",
                            "squareDefaultImage",
                            "squareDefaultImage",
                            "squareDefaultImage",
                            "squareDefaultImage"]
    
    var bookstoreLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "책발전소광교"
        $0.sizeToFit()
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var timeButton: UIButton = UIButton().then {
        $0.setTitle("   영업중   ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 14
        $0.backgroundColor = UIColor(hexCode: "#00C950")
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "4.53"
    }
    
    var reviewCountLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 132"
        $0.sizeToFit()
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "경기도 수원시 팔달구 매산로52번길 20"
    }
    
    lazy var photosCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.itemSize = CGSize(width: 120, height: 120)
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    
    // MARK: View
    
    func setUpView() {
        self.selectionStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookstoreLabel,
            bookMarkImageView,
            timeButton,
            starImageView,
            starLabel,
            reviewCountLabel,
            locationLabel,
            photosCollectionView
        ].forEach { self.contentView.addSubview($0) }
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookstoreLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookstoreLabel)
            $0.leading.equalTo(bookstoreLabel.snp.trailing).offset(10)
        }
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(bookstoreLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bookstoreLabel.snp.leading)
        }
        
        timeButton.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bookstoreLabel.snp.leading)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalTo(timeButton.snp.trailing).offset(5)
            $0.centerY.equalTo(timeButton.snp.centerY)
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(timeButton.snp.centerY)
        }
        
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(starLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(timeButton.snp.centerY)
        }

        photosCollectionView.snp.makeConstraints {
            $0.top.equalTo(timeButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}//end of MainPageBookStoreTableViewCell


// MARK: Extension

extension MainPageBookStoreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookStorePhotoCell", for: indexPath) as! BookStorePhotoCollectionViewCell
        
        cell.photoImageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct MainPageBookStoreTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = MainPageBookStoreTableViewCell()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

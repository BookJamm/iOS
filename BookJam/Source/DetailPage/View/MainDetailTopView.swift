//
//  MainDetailTopView.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit

class MainDetailTopView: UIView {

    // MARK: Variables
    
    var contentView: UIView = UIView()
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    }).then {
        $0.backgroundColor = .white
//        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    var bookstoreLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "책방연희"
        $0.sizeToFit()
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var storeTypeLabel : UILabel = UILabel().then {
        $0.font = paragraph04
        $0.textColor = gray06
        $0.text = "독립서점"
        $0.sizeToFit()
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "3.75"
        $0.sizeToFit()
    }
    
    var reviewCountLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "리뷰 5"
        $0.sizeToFit()
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }
    
    var clockImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "clock.fill")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "서울특별시 마포구 와우산로35길 3 (서교동) 지하 1층"
        $0.sizeToFit()
    }
    
    var timeLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = complete
        $0.text = "영업 중"
        $0.sizeToFit()
    }
    
    var siteURL: UIButton = UIButton().then {
        $0.setTitle("https://www.instagram.com/chaegbangyeonhui/", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.contentHorizontalAlignment = .leading
//        $0.addTarget(self, action: #selector(didURLTapped), for: .touchUpInside)
    }
    
    // MARK: Layout
    
    func setUpLayout() {
        self.addSubview(contentView)
        
        [
        photoCollectionView,
        bookstoreLabel,
        bookMarkImageView,
        storeTypeLabel,
        starImageView,
        starLabel,
        reviewCountLabel,
        underLineView,
        locationPinImageView,
        clockImageView,
        locationLabel,
        timeLabel,
        siteURL
        ].forEach{ contentView.addSubview($0)}
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        bookstoreLabel.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(20)
        }
        
        bookMarkImageView.snp.makeConstraints {
            $0.leading.equalTo(bookstoreLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(bookstoreLabel)
        }
        
        storeTypeLabel.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.bottom.equalTo(bookstoreLabel).offset(30)
        }
        
        starImageView.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.top.equalTo(storeTypeLabel.snp.bottom).offset(12)
            $0.width.height.equalTo(20)
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(starImageView)
        }
        
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
            $0.centerY.equalTo(starImageView)
        }
        
        underLineView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
            $0.top.equalTo(starImageView.snp.bottom).offset(16)
        }
        
        locationPinImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.left.equalTo(starImageView)
            $0.bottom.equalTo(underLineView).offset(40)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(locationPinImageView)
        }
        
        clockImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerX.equalTo(locationPinImageView)
            $0.bottom.equalTo(locationPinImageView).offset(30)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(clockImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(clockImageView)
        }
        
        siteURL.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(clockImageView).offset(35)
        }
        
    }//end of setupConstraint
    
}

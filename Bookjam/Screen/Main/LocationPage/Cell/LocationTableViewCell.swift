//
//  LocationPageBookStoreTableViewCell.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/28.
//

// MARK: - 지도 페이지 화면 책방 목록 표시할 때 들어갈 책방 정보 TableView 셀

import UIKit
import SwiftUI

import SnapKit
import Then


class LocationTableViewCell: UITableViewCell {
    
    // MARK: - Cell ViewModel
    var cellModel: GetPlaceResponseModel? {
        didSet {
            fetchCellData()
        }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fetchCellData()
        photosCollectionView.reloadData()
    }
    
    
    // MARK: Variable
    
    static let cellID = "LocationTableViewCell"
    
    var images: [Image] = []
    
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
        $0.font = paragraph02
        $0.text = "4.53"
    }
    
    var reviewCountLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "리뷰 132"
        $0.sizeToFit()
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = gray06
        $0.text = "경기도 수원시 팔달구 매산로52번길 20"
    }
    
    var photosCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.itemSize = CGSize(width: 100, height: 100)
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    // MARK: - Cell Model Data Fetching
    /// Cell Model의 데이터를 UI에 반영합니다
    func fetchCellData() {
        self.bookstoreLabel.text = self.cellModel?.name ?? "이름 없음"
        self.locationLabel.text = self.cellModel?.address?.road ?? "주소 없음"
        self.changeStatus(isOpen: self.cellModel?.open)
        self.starLabel.text = self.cellModel?.rating?.description ?? "0.0"
        self.reviewCountLabel.text =  "리뷰 " + (self.cellModel?.reviewCount?.description ?? "0")
        self.images = self.cellModel?.images ?? []
    }
    
    /// 해당 서점의 현재 상태를 확인하고, 영업 중 라벨을 변경합니다.
    private func changeStatus(isOpen: Bool?) {
        // 데이터가 없는 경우
        guard let isOpen = isOpen else {
            self.timeButton.setTitle("   미등록   ", for: .normal)
            self.timeButton.backgroundColor = gray06
            return
        }
        
        // 영업 여부에 따라 분기처리
        let isOpenText = isOpen ? "   영업중   " : "   영업 종료   "
        let backgroundColor = isOpen ? complete : alert
        
        // UI 처리
        self.timeButton.setTitle(isOpenText, for: .normal)
        self.timeButton.backgroundColor = backgroundColor
        
    }
    
    
    // MARK: View
    
    func setUpView() {
        self.selectionStyle = .none
        fetchCellData()
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
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
}//end of MainPageBookStoreTableViewCell


// MARK: Extension

extension LocationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return images.isEmpty ? 1 : images.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookStorePhotoCell", for: indexPath) as! BookStorePhotoCollectionViewCell
        
        if images.isEmpty {
            // 이미지 배열이 비어있으면 기본 이미지 설정
            cell.photoImageView.image = UIImage(named: "squareDefaultImage")
        }
        else {
            // 이미지 데이터가 있을 경우 해당 이미지 설정
            cell.photoImageView.kf.setImage(with: URL(string: images[indexPath.row].url!), placeholder: UIImage(named: "squareDefaultImage"))
        }
        
        cell.photoImageView.layer.cornerRadius = 8
                    
        
        return cell
    }
    
    // 가로스크롤 구현을 위해 height 사이즈 collectionView 사이즈로 고정
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

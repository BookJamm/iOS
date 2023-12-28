//
//  MainDetailReviewTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/18/23.
//

import UIKit

class MainDetailReviewTableViewCell: UITableViewCell {

    static let id =  "HomeReviewTabCell"
    
    var profileImageView: UIImageView = UIImageView().then {
//        $0.image = UIImage(named: "squareDefaultImage")?.circularImage()
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var nickNameLabel: UILabel = UILabel().then{
        $0.text = "독서 광인"
        $0.font = paragraph05
    }
    
    var reviewContent: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "주말이라 사람들이 많아서 커피를 마시지는 못했지만, 독립서점에서 볼법한 책들도 판매하고 있어 구경하는 재미가 있었어요!"
        $0.numberOfLines = 20
        $0.sizeToFit()
    }
    
    var reviewDate: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "yyyy / mm / dd 방문"
        $0.sizeToFit()
    }
    var photosCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.itemSize = CGSize(width: 100, height: 100)
        
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.id)
        $0.backgroundColor = .blue  //임시
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
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            profileImageView,
            nickNameLabel,
            reviewDate,
            reviewContent,
            photosCollectionView
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        profileImageView.snp.makeConstraints{
            $0.size.equalTo(40)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(26)
        }
        nickNameLabel.snp.makeConstraints{
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.top.equalTo(profileImageView)
        }
        reviewDate.snp.makeConstraints{
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nickNameLabel)
        }
        reviewContent.snp.makeConstraints{
            $0.top.equalTo(reviewDate.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        photosCollectionView.snp.makeConstraints{
            $0.top.equalTo(reviewContent.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(88)
        }
        
    }
    
//    public func configure(title: String, content: String) {
//        newsLabel.text = title
//        newsContent.text = content
//    }
}

#if DEBUG
import SwiftUI

@available(iOS 16.0, *)
struct MainDetailReviewTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailReviewTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

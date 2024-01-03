//
//  BookActivityCollectionViewCell.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

// MARK: - 홈 탭 독서 활동 참여 목록에 표시될 독서 활동 정보 셀

import UIKit
import SwiftUI

import SnapKit
import Then
import Kingfisher

class BookActivityCollectionViewCell: UICollectionViewCell {
    // MARK: Variables
    
    // CollectionView가 여러 개라 extension 분기 나누는 거 고려해서 cell id 전부 homeViewCell로 통일
    static var id = "homeActivityCell"
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = title03
        $0.textColor = .black
        $0.text = "여행하는 독서모임"
        
    }
    
    var dateLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "11월 29일(수) 16:00"
        $0.sizeToFit()
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }

    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "책발전소 광교"
        $0.sizeToFit()
    }
    
    var activityTypeButton: UIButton = UIButton().then {
        $0.setTitle("    글쓰기    ", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 14
        $0.backgroundColor = main05
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityImageView,
            titleLabel,
            dateLabel,
            locationLabel,
            locationPinImageView,
            activityTypeButton,
          
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(activityImageView.snp.trailing).offset(12)
            $0.top.equalTo(activityImageView)
        }
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        locationPinImageView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(dateLabel)
        }
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(locationPinImageView)
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(4)
        }
        activityTypeButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(32)
            $0.leading.equalTo(locationPinImageView)
        }
        
        
    }
    
    // MARK: Functions
    
    // 참여하기 버튼 누르면 실행되는 메소드
    @objc func didJoinButtonTapped() {
        
    }
    
    public func configure(title: String, url: String) {
        titleLabel.text = title
        activityImageView.kf.setImage(with: URL(string: url))
    }
}

#if DEBUG

@available(iOS 16.0, *)
struct BookActivityCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = BookActivityCollectionViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

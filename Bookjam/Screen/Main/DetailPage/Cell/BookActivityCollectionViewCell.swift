//
//  BookActivityCollectionViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/06.
//

// MARK: - 홈 탭 독서 활동 참여 목록에 표시될 독서 활동 정보 셀

import UIKit
import SwiftUI

import SnapKit
import Then


class BookActivityCollectionViewCell: UICollectionViewCell {
    // MARK: Variables
    
    // CollectionView가 여러 개라 extension 분기 나누는 거 고려해서 cell id 전부 homeViewCell로 통일
    static var cellID = "homeViewCell"
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph01
        $0.textColor = main03
        $0.text = "활동 이름"
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var ratingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var heartImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .black
    }
    
    var shareImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "arrowshape.turn.up.right")
        $0.tintColor = .black
                           
    }
    
    var joinButton: UIButton = UIButton().then {
        $0.setTitle("참여하기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "834205"), for: .normal)
        $0.titleLabel?.font = captionText01
        $0.layer.borderWidth = 0.7
        $0.layer.borderColor = UIColor(hexCode: "834205").cgColor
        $0.layer.cornerRadius = 14
         $0.addTarget(self, action: #selector(didJoinButtonTapped), for: .touchUpInside)
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
            starImageView,
            ratingLabel,
            heartImageView,
            shareImageView,
            joinButton
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(activityImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(2)
        }
        
        heartImageView.snp.makeConstraints {
            $0.top.equalTo(starImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        
        shareImageView.snp.makeConstraints {
            $0.centerY.equalTo(heartImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(heartImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(activityImageView)
        }
    }
    
    // MARK: Functions
    
    // 참여하기 버튼 누르면 실행되는 메소드
    @objc func didJoinButtonTapped() {
        
    }
}

#if DEBUG

@available(iOS 13.0, *)
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


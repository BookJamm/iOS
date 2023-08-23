//
//  ActivityParticipateCollectionViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/08.
//

import UIKit
import SwiftUI

import SnapKit
import Then

class ActivityParticipateCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Variables
    
    static let cellID = "activityCell"
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var activityNameLabel: UILabel = UILabel().then{
        $0.text = "행복마실 어르신 책놀이"
        $0.textColor = main03
        $0.font = paragraph01
        $0.sizeToFit()
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starValueLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "4.93"
    }
    
    var numOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var detailViewButton: UIButton = UIButton().then{
        $0.setTitle("자세히 보기", for: .normal)
        $0.titleLabel?.font = paragraph04
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = UIColor.clear
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        
        [
            activityImageView,
            activityNameLabel,
            starImageView,
            starValueLabel,
            numOfReviewLabel,
            detailViewButton
        ].forEach{ self.contentView.addSubview($0) }
        
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
        activityImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.height.equalTo(100)
        }
        activityNameLabel.snp.makeConstraints{
            $0.top.equalTo(activityImageView).offset(10)
            $0.leading.equalTo(activityImageView.snp.trailing).offset(15)
            $0.height.equalTo(24)
        }
        starImageView.snp.makeConstraints{
            $0.leading.equalTo(activityNameLabel).inset(-1)
            $0.top.equalTo(activityNameLabel.snp.bottom).offset(10)
            $0.height.width.equalTo(20)
        }
        starValueLabel.snp.makeConstraints{
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        numOfReviewLabel.snp.makeConstraints{
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starValueLabel.snp.trailing).offset(10)
        }
        detailViewButton.snp.makeConstraints{
            $0.top.equalTo(starImageView.snp.bottom).offset(20)
            $0.bottom.equalTo(activityImageView.snp.bottom)
            $0.leading.equalTo(starImageView)
            $0.trailing.equalToSuperview().offset(-20).priority(.high)
            $0.height.equalTo(40)
        }
    }
}

//#if DEBUG
//
//@available(iOS 13.0, *)
//struct ActivityParticipateCollectionViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let cell = ActivityParticipateCollectionViewCell()
//            return cell
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

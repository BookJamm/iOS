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
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Variable

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
    
    var timeButton: UIButton = UIButton().then{
        $0.setTitle("영업중", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
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
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "경기도 수원시 팔달구 매산로52번길 20"
    }
    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = UIColor(hexCode: "F5F4F3")
        self.contentMode = .scaleAspectFit
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
           timeButton
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookstoreLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookstoreLabel)
            $0.leading.equalTo(bookstoreLabel.snp.trailing).offset(10)
        }
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(bookstoreLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookstoreLabel.snp.leading)
        }
        timeButton.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookstoreLabel.snp.leading)
        }
        starImageView.snp.makeConstraints{
            $0.leading.equalTo(timeButton.snp.trailing).offset(15)
            $0.centerY.equalTo(timeButton.snp.centerY)
            
        }
        starLabel.snp.makeConstraints{
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(timeButton.snp.centerY)

        }
        reviewCountLabel.snp.makeConstraints{
            $0.leading.equalTo(starLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(timeButton.snp.centerY)
        }
    }

}//end of MainPageBookStoreTableViewCell

#if DEBUG
import SwiftUI

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

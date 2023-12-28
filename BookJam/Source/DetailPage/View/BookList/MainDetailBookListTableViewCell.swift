//
//  MainDetailBookListTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/22/23.
//

import UIKit


class MainDetailBookListTableViewCell: UITableViewCell {

    static let id =  "HomeBookListTabCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "emptyBook")
    }
    
    var locationLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "책발전소 광교"
        $0.textColor  = gray06
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
        $0.text = "우리는 중독을 사랑해"
    }
    
    var bookCategoryButton: UIButton = UIButton().then {
        $0.setTitle("인문학", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.titleLabel?.font = captionText02
        $0.layer.cornerRadius = 14
        
        $0.backgroundColor = gray01
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "도우리"
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "한겨레 출판사"
    }
    
    var priceLabel: UILabel = UILabel().then{
        $0.text = "10,000원"
        $0.font = paragraph03
        $0.textColor = gray09
    }
    
    var line: UIView = UIView().then{
        $0.backgroundColor = gray03
    }
    
    var line2: UIView = UIView().then{
        $0.backgroundColor = gray03
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
            bookImageView,
            locationLabel,
            locationPinImageView,
            titleLabel,
            bookCategoryButton,
            authorLabel,
            publisherLabel,
            priceLabel,
            line,
            line2
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(12)
        }
        
        locationPinImageView.snp.makeConstraints{
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(12)
        }
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(locationPinImageView)
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(4)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(locationPinImageView)
        }
        bookCategoryButton.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(locationPinImageView)
        }
        line.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(8)
            $0.leading.equalTo(bookCategoryButton.snp.trailing).offset(8)
            $0.centerY.equalTo(bookCategoryButton)
        }
        authorLabel.snp.makeConstraints{
            $0.leading.equalTo(line.snp.trailing).offset(8)
            $0.centerY.equalTo(line)
        }
        line2.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(8)
            $0.centerY.equalTo(line)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(8)
        }
        publisherLabel.snp.makeConstraints{
            $0.centerY.equalTo(line)
            $0.leading.equalTo(line2.snp.trailing).offset(8)
        }
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(publisherLabel.snp.bottom).offset(4)
            $0.leading.equalTo(bookCategoryButton)
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
struct MainDetailBookListTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailBookListTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

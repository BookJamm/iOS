//
//  LikeActivityTableViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/07.
//

import UIKit
import SwiftUI

class LikeActivityTableViewCell: UITableViewCell {

    // MARK: Variables
    
    var cellID = "LikeActivityCell"

    var bookStoreName: UILabel = UILabel().then{
        $0.text = "책발전소광교"
        $0.font = paragraph05
        $0.textColor = gray06
        $0.sizeToFit()
    }
    
    var bookStoreImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var activityNameLabel: UILabel = UILabel().then{
        $0.text = "북 큐레이팅"
        $0.font = paragraph01
        $0.sizeToFit()
        
    }
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starValueLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "4.93"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add spacing around the cell's content
        let inset: CGFloat = 10.0 // Adjust the spacing as needed
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
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
            bookStoreName,
            bookMarkImageView,
            bookStoreImageView,
            activityNameLabel,
            starImageView,
            starValueLabel,
            detailViewButton,
            
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookStoreImageView.snp.makeConstraints{
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(120)
        }
        bookStoreName.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(bookStoreImageView.snp.trailing).offset(10)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.top.equalTo(bookStoreName)
            $0.leading.equalTo(bookStoreName.snp.trailing).offset(5)
        }
        activityNameLabel.snp.makeConstraints{
            $0.top.equalTo(bookStoreName.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreName)
        }
        starImageView.snp.makeConstraints{
            $0.top.equalTo(activityNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(activityNameLabel)
        }
        starValueLabel.snp.makeConstraints{
            $0.top.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        detailViewButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(starImageView)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct LikeActivityTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = LikeActivityTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  RecordMoreTableViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/03.
//

import UIKit
import SwiftUI

class RecordMoreTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        
//        contentView.backgroundColor = gray01
    }
    
    //셀 간 간격 두기
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 10 // Adjust the corner radius value as needed
           contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Variables
    
    var cellID = "RecordTableCell"

    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var visitDayLabel: UILabel = UILabel().then{
        $0.text = "2023 / 06/ 06 방문"
        $0.textColor = main03
        $0.font = captionText01
        $0.sizeToFit()
    }
    
    var bookStoreNameLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책발전소광교"
        $0.sizeToFit()
    }

    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var speechBubbleImageView : UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "bubble.left")
        $0.tintColor = .black
    }

    var speechBubbleLabel: UILabel = UILabel().then{
        $0.text = "213"
    }
    
    var heartImageView : UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .black
    }
    
    var heartLabel: UILabel = UILabel().then{
        $0.text = "213"
    }
    
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityImageView,
            visitDayLabel,
            bookMarkImageView,
            bookStoreNameLabel,
            speechBubbleLabel,
            speechBubbleImageView,
            heartLabel,
            heartImageView,
            
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
            $0.width.equalTo(120)
        }
        visitDayLabel.snp.makeConstraints{
            $0.top.equalTo(activityImageView)
            $0.leading.equalTo(activityImageView.snp.trailing).offset(10)
        }
        bookStoreNameLabel.snp.makeConstraints{
            $0.top.equalTo(visitDayLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(visitDayLabel)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookStoreNameLabel)
            $0.leading.equalTo(bookStoreNameLabel.snp.trailing).offset(5)
        }
        speechBubbleImageView.snp.makeConstraints{
            $0.top.equalTo(bookStoreNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreNameLabel)
        }
        speechBubbleLabel.snp.makeConstraints{
            $0.centerY.equalTo(speechBubbleImageView)
            $0.leading.equalTo(speechBubbleImageView.snp.trailing).offset(5)
        }
        heartImageView.snp.makeConstraints{
            $0.leading.equalTo(speechBubbleLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(speechBubbleImageView)
        }
        heartLabel.snp.makeConstraints{
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(heartImageView)
        }
        
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct RecordMoreTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = RecordMoreTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

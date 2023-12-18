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
        $0.font = paragraph06
    }
    
    var newsView: UIView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = gray02
    }
    
    var newsLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "뉴스 제목"
        $0.sizeToFit()
    }
    
    var newsContent: UILabel = UILabel().then {
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
            newsView
        ].forEach { self.addSubview($0) }
        
        [
            newsLabel,
            newsContent,
            
        ].forEach { newsView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
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

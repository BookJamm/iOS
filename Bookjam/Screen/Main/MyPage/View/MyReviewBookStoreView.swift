//
//  MyReviewBookStoreView.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/09.
//

import UIKit

class MyReviewBookStoreView: UIView {

    // MARK: Variables
    
    var bookStoreName: UILabel = UILabel().then{
        $0.text = "책발전소광교"
        $0.font = title06
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
    
    var bookNameButton: UIButton = UIButton().then{
        $0.setTitle("책 이름입니다.", for: .normal)
        $0.titleLabel?.font = paragraph05
        $0.setTitleColor(gray06, for: .normal)
        $0.layer.backgroundColor = gray02?.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = gray04?.cgColor
        $0.layer.borderWidth = 1.0
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
    
    var visitDayLabel: UILabel = UILabel().then{
        $0.text = "2023 / 06 / 06 방문"
        $0.font = captionText03
        $0.textColor = gray05
        $0.sizeToFit()
    }
    
    override func draw(_ rect: CGRect) {
//        setUpView()
        setUpLayout()
//        setUpDelegate()
        setUpConstraint()
    }
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookStoreName,
            bookStoreImageView,
            bookMarkImageView,
            bookNameButton,
            visitDayLabel,
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookStoreImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(166)
        }
        bookStoreName.snp.makeConstraints{
            $0.top.equalTo(bookStoreImageView.snp.bottom).offset(10)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookStoreName)
            $0.leading.equalTo(bookStoreName.snp.trailing).offset(10)
        }
        bookNameButton.snp.makeConstraints{
            $0.top.equalTo(bookStoreName.snp.bottom).offset(15)
            $0.width.equalTo(105)
        }
        visitDayLabel.snp.makeConstraints{
            $0.top.equalTo(bookNameButton.snp.bottom).offset(15)
        }
        
    }
    
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct MyReviewBookStoreView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = MyReviewBookStoreView()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
//#endif

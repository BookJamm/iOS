//
//  MyRecordBookStoreView.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/09.
//

import UIKit

class MyRecordBookStoreView: UIView {

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
            speechBubbleLabel,
            speechBubbleImageView,
            heartLabel,
            heartImageView,
            visitDayLabel
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
        speechBubbleImageView.snp.makeConstraints{
            $0.top.equalTo(bookStoreName.snp.bottom).offset(10)
        }
        speechBubbleLabel.snp.makeConstraints{
            $0.centerY.equalTo(speechBubbleImageView)
            $0.leading.equalTo(speechBubbleImageView.snp.trailing).offset(10)
        }
        heartImageView.snp.makeConstraints{
            $0.centerY.equalTo(speechBubbleImageView)
            $0.leading.equalTo(speechBubbleLabel.snp.trailing).offset(20)
        }
        heartLabel.snp.makeConstraints{
            $0.centerY.equalTo(speechBubbleImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(10)
        }
        visitDayLabel.snp.makeConstraints{
            $0.top.equalTo(speechBubbleImageView.snp.bottom).offset(10)
            
        }
    }
    
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct MyRecordBookStoreView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = MyRecordBookStoreView()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
//#endif

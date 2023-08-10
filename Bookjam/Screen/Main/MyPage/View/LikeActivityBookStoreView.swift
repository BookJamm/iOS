//
//  LikeActivityBookStoreView.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/10.
//

import UIKit

class LikeActivityBookStoreView: UIView {

    // MARK: Variables
    
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
            activityNameLabel,
            starImageView,
            starValueLabel,
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookStoreImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        bookStoreName.snp.makeConstraints{
            $0.top.equalTo(bookStoreImageView.snp.bottom).offset(10)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookStoreName)
            $0.leading.equalTo(bookStoreName.snp.trailing).offset(10)
        }
        activityNameLabel.snp.makeConstraints{
            $0.top.equalTo(bookStoreName.snp.bottom).offset(10)
        }
        starImageView.snp.makeConstraints{
            $0.top.equalTo(activityNameLabel.snp.bottom).offset(10)
            $0.height.width.equalTo(20)
        }
        starValueLabel.snp.makeConstraints{
            $0.leading.equalTo(starImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(starImageView)
        }
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LikeActivityBookStoreView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = LikeActivityBookStoreView()
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

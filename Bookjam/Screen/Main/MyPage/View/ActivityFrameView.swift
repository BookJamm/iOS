//
//  ActivityFrameView.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/09.
//

import UIKit

class ActivityFrameView: UIView {

    
    // MARK: Variables
    
    var recordLabel: UILabel = UILabel().then{
        $0.text = "기록"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var recordNumberLabel: UILabel = UILabel().then{
        $0.text = "NN"
        $0.font = title06
        $0.textColor = main03
        $0.sizeToFit()
    }
    
    var visitLabel : UILabel = UILabel().then{
        $0.text = "방문"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var visitNumberLabel: UILabel = UILabel().then{
        $0.text = "NN"
        $0.font = title06
        $0.textColor = main03
        $0.sizeToFit()
    }
    var reviewLabel: UILabel = UILabel().then{
        $0.text = "리뷰"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var reviewNumberLabel: UILabel = UILabel().then{
        $0.text = "NN"
        $0.font = title06
        $0.textColor = main03
        $0.sizeToFit()
    }
    
    var underLineView1: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var underLineView2: UIView = UIView().then {
        $0.backgroundColor = gray04
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
            recordLabel,
            recordNumberLabel,
            visitLabel,
            visitNumberLabel,
            reviewLabel,
            reviewNumberLabel,
            underLineView1,
            underLineView2
        ].forEach { self.addSubview($0) }
        
        self.backgroundColor = main05
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
      
        recordLabel.snp.makeConstraints{
            $0.centerX.equalTo(underLineView1).multipliedBy(0.5)
        }
        recordNumberLabel.snp.makeConstraints{
            $0.centerX.equalTo(recordLabel)
            $0.centerY.equalTo(recordLabel).offset(20)
        }
        
        visitLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
        }
        visitNumberLabel.snp.makeConstraints{
            $0.centerX.equalTo(visitLabel)
            $0.centerY.equalTo(visitLabel).offset(20)
        }
        
        reviewLabel.snp.makeConstraints{
            $0.centerX.equalTo(underLineView2).multipliedBy(1.25)
        }
        reviewNumberLabel.snp.makeConstraints{
            $0.centerX.equalTo(reviewLabel)
            $0.centerY.equalTo(reviewLabel).offset(20)
        }
        
        underLineView1.snp.makeConstraints{
            $0.centerX.equalToSuperview().multipliedBy(0.66)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(1)
        }
        underLineView2.snp.makeConstraints{
            $0.centerX.equalToSuperview().multipliedBy(1.33)
            
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(1)
        }
        
    }//end of setUpConstraint
    
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ActivityFrameView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = ActivityFrameView()
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

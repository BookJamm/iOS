//
//  MainDetailSegmentedControl.swift
//  BookJam
//
//  Created by 장준모 on 11/16/23.
//

import UIKit

class MainDetailSegmentedControl: UISegmentedControl {

    override init(items: [Any]?) {
        super.init(items: items)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .white
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: gray04!,
            NSAttributedString.Key.font: paragraph03
        ], for: .normal)
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: main03!,
            NSAttributedString.Key.font: paragraph03
            
        ], for: .selected)
        
        // Default segments
        insertSegment(withTitle: "홈", at: 0, animated: true)
        insertSegment(withTitle: "소식", at: 1, animated: true)
        insertSegment(withTitle: "참여", at: 2, animated: true)
        insertSegment(withTitle: "리뷰", at: 3, animated: true)
        insertSegment(withTitle: "책 종류", at: 4, animated: true)

        
        // Default selected segment
        selectedSegmentIndex = 0
        
    }

}

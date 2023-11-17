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
//        insertSegment(withTitle: "유저", at: 0, animated: true)
//        insertSegment(withTitle: "게시물", at: 1, animated: true)
        
        // Default selected segment
        selectedSegmentIndex = 0
        
        // Add target for value change
        addTarget(self, action: #selector(didFeedSegmentControllerValueChanged), for: .valueChanged)
    }
    
    @objc private func didFeedSegmentControllerValueChanged() {
        
    }

}

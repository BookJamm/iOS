//
//  MainDetailHomeHeader.swift
//  BookJam
//
//  Created by 장준모 on 12/11/23.
//

import UIKit

class MainDetailHomeHeader: UITableViewHeaderFooterView {

    // MARK: Variables
    
    static let id = "MainDetailHomeHeader"
    
    var segmentedControl = MainDetailSegmentedControl()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure() {
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    // MARK: View
    
    func setUpView() {
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
//        self.addSubview(segmentedControl)
        self.contentView.addSubview(segmentedControl)

    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        segmentedControl.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Function


}

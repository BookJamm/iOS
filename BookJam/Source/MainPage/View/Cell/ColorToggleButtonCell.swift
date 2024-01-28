//
//  ColorToggleButtonCell.swift
//  BookJam
//
//  Created by 박민서 on 1/29/24.
//

import UIKit
import SnapKit

class ColorToggleButtonCell: UICollectionViewCell {
    
    static let id = "ColorToggleButtonCell"
    
    private lazy var colorButton = ColorToggleButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: View
    func setUpView() {
        self.backgroundColor = .white
//        self.colorButton.isUserInteractionEnabled = false
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            colorButton
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    func setUpConstraint() {
        colorButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func toggleButtonStatus() {
        self.colorButton.isOn.toggle()
    }
    
    func configure(title: String, isOn: Bool) {
        colorButton.titleString = title
        colorButton.isOn = isOn
    }
}

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
    
    lazy var colorButton = ColorToggleButton(title: "")
    var category: BookClubCategory?
    
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
        self.colorButton.isOn = false
    }
    
    // MARK: View
    func setUpView() {
        self.backgroundColor = .clear
        self.colorButton.titleLabel?.numberOfLines = 1
        self.colorButton.isUserInteractionEnabled = false
        self.colorButton.backgroundColor = .white
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
    
    func makeButton(status: Bool) {
        self.colorButton.isOn = status
    }
    
    func configure(category: BookClubCategory) {
        self.category = category
        colorButton.titleString = category.toKorean
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ColorToggleButtonCell()
//        .configure(category: .academicWriting)
//}

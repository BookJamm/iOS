//
//  MainPageBookStoreTableViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/02.
//

import UIKit
import SwiftUI

import SnapKit
import Then

class MainPageBookStoreTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Variable

    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = UIColor(hexCode: "F5F4F3")
        self.contentMode = .scaleAspectFit
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
           
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MainPageBookStoreTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = MainPageBookStoreTableViewCell()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

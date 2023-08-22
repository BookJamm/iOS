//
//  TableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/14.
//

// MARK: - TableView 만들 때마다 템플릿으로 사용할 파일입니다.

import SwiftUI
import UIKit

import SnapKit
import Then


class TableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    var cellID = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            
        ].forEach { self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
}

//
//#if DEBUG
//
//@available(iOS 13.0, *)
//struct TableViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let cell = TableViewCell()
//            return cell
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

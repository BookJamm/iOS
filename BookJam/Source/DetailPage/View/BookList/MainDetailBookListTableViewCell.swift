//
//  MainDetailBookListTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/22/23.
//

import UIKit


class MainDetailBookListTableViewCell: UITableViewCell {

    static let id =  "HomeBookListTabCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "emptyBook")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
        $0.text = "등록된 책이 없습니다."
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = ""
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = ""
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
//    public func configure(title: String, content: String) {
//        newsLabel.text = title
//        newsContent.text = content
//    }
}

#if DEBUG
import SwiftUI

@available(iOS 16.0, *)
struct MainDetailBookListTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailBookListTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

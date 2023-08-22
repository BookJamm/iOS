//
//  SearchResultTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/13.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class SearchResultTableViewCell: UITableViewCell {
    
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
    
    
    // MARK: Variable
    
    static let cellID = "searchResultCell"
    
    var storeNameLabel: UILabel = UILabel().then {
        $0.text = "아주 멋진 독립서점"
        $0.font = paragraph02
    }
    
    var storeTypeImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var locationImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.tintColor = gray07
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.text = "경기도 수원시 팔달구 매산로52번길 20"
        $0.font = paragraph05
        $0.textColor = gray06
    }

    // MARK: View
    
    func setUpView() {
        self.selectionStyle = .none
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            storeNameLabel,
            storeTypeImageView,
            locationImageView,
            locationLabel,
        ].forEach { self.contentView.addSubview($0) }
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        storeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        storeTypeImageView.snp.makeConstraints {
            $0.centerY.equalTo(storeNameLabel)
            $0.leading.equalTo(storeNameLabel.snp.trailing).offset(5)
        }
        
        locationImageView.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(storeNameLabel)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}


//#if DEBUG
//
//@available(iOS 13.0, *)
//struct SearchResultTableViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = SearchResultTableViewCell()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

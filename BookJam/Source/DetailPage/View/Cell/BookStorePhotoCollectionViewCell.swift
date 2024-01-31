//
//  BookStorePhotoCollectionViewCell.swift
//  BookJam
//
//  Created by 장준모 on 11/13/23.
//

// MARK: - 메인 페이지의 책방별 사진/디테일 페이지 상단에 위치한 사진 5개 구현에 사용되는 셀

import UIKit
import SwiftUI

import SnapKit
import Then


class BookStorePhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    
    static var id = "bookStorePhotoCell"
    
    var photoImageView: UIImageView = UIImageView().then {
//        $0.image = UIImage(named: "squareDefaultImage")
        $0.image = .squareDefault
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        photoImageView.image = UIImage(named: "squareDefaultImage")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        self.addSubview(photoImageView)
        self.clipsToBounds = true
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

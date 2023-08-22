//
//  BookStorePhotoCollectionViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/05.
//

// MARK: - 메인 페이지의 책방별 사진/디테일 페이지 상단에 위치한 사진 5개 구현에 사용되는 셀

import UIKit
import SwiftUI

import SnapKit
import Then


class BookStorePhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    
    static var cellID = "bookStorePhotoCell"
    
    var photoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
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

//#if DEBUG
//
//@available(iOS 13.0, *)
//struct BookStorePhotoCollectionViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let cell = BookStorePhotoCollectionViewCell()
//            return cell
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

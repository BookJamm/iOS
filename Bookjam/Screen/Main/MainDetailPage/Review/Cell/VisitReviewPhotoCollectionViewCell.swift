//
//  VisitReviewPhotoCollectionViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/13.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class VisitReviewPhotoCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Variables
    
    static let cellID = "visitReviewPhotoCell"
    
    var photoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
    }
    
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            photoImageView
        ].forEach{ self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        photoImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct VisitReviewPhotoCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = VisitReviewPhotoCollectionViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  BookstoreDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/28.
//

import SwiftUI
import UIKit

import SnapKit
import Tabman
import Then

class BookstoreDetailVC: UIViewController, UICollectionViewDelegate {

    // MARK: Variables
    
    var scrollView: UIScrollView  = UIScrollView().then {
        $0.backgroundColor = .blue
    }
    
    var photoStackView: UIStackView = UIStackView().then {
        $0.backgroundColor = .black
        $0.spacing = 1
    }
    
    var firstPhotoImageView: UIImageView = UIImageView().then {
        $0.backgroundColor = .yellow
    }
    
    var photoCollectionView: UIStackView = UIStackView().then {
        $0.backgroundColor = .brown
    }
    
    var bookstoreLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "천천히 스미는"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.sizeToFit()
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = UIColor(hexCode: "C1C1C1")
    }
    
    var storeTypeLabel : UILabel = UILabel().then {
        $0.textColor = gray06
        $0.textAlignment = .left
        $0.text = "독립서점"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.sizeToFit()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        photoStackView.addArrangedSubview(firstPhotoImageView)
        photoStackView.addArrangedSubview(photoCollectionView)
        [
            photoStackView,
            bookstoreLabel
        ].forEach { scrollView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.height.equalTo(UIScreen.main.bounds.size.height)
        }
        
        photoStackView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        
        firstPhotoImageView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
            $0.height.equalToSuperview()
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
            $0.height.equalToSuperview()
        }
        
        bookstoreLabel.snp.makeConstraints {
            $0.bottom.equalTo(photoStackView).multipliedBy(1.2)
            $0.centerX.equalTo(photoStackView).multipliedBy(0.35)
        }
    }
}

// MARK: Extension

struct BookstoreDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookstoreDetailVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}


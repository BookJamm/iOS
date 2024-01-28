//
//  BookClubCategoryView.swift
//  BookJam
//
//  Created by 박민서 on 1/28/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxRelay

/// MainPage의 BookClub 탭 시 CollectionViewHeader 위에 표시되는 View입니다.
final class BookClubCategoryView: UICollectionViewCell {
    
    // MARK: Variables
    
    static let id = "BookClubCategoryView"
    
    // Rx - DisposeBag
    let disposeBag = DisposeBag()
    
    // Rx - ViewModel
    var viewModel: MainPageClubCategoryViewModel? {
        didSet {
            setUpBinding()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpBinding()
        setUpLayout()
        setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .white
    }
    
    private func setUpBinding() {
             
    }
    
    private func setUpLayout() {
        [

        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        
    }
}

@available(iOS 17.0, *)
#Preview {
    BookClubCategoryView()
}

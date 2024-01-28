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
final class BookClubCategoryView: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
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
    
    private var categoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing  = 10
    }).then {
        $0.register(ColorToggleButtonCell.self, forCellWithReuseIdentifier: ColorToggleButtonCell.id)
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
        
        categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setUpBinding() {
        // MARK: Input
        let input = MainPageClubCategoryViewModel.Input(
            clubCategorySelectEvent: <#Observable<BookClubCategory>#>,
            clubCategorySelectAllEvent: <#Observable<Void>#>)
        
        // MARK: Output
        let output = viewModel?.transform(input: input)
        
        Observable.just(BookClubCategory.allCases)
            .bind(to: categoryCollectionView.rx.items(
                cellIdentifier: ColorToggleButtonCell.id, 
                cellType: ColorToggleButtonCell.self
            )) { index, category, cell in
                cell.configure(title: category.toKorean, isOn: <#T##Bool#>)
            }
            .disposed(by: disposeBag)
        
        output?.selectedClubCategory
            .bind { categoryList in
                
                categoryCollectionView.cellForItem(at: <#T##IndexPath#>)
            }
    }
    
    private func setUpLayout() {
        [
            categoryCollectionView
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    BookClubCategoryView()
}

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
    
    private var cellsList: [ColorToggleButtonCell] = []
    
    private var categoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing  = 10
    }).then {
        $0.register(ColorToggleButtonCell.self, forCellWithReuseIdentifier: ColorToggleButtonCell.id)
        $0.backgroundColor = .clear
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
//        setUpBinding()
        setUpLayout()
        setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .gray01
        
        categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.just(BookClubCategory.allCases)
            .bind(to: categoryCollectionView.rx.items(
                cellIdentifier: ColorToggleButtonCell.id,
                cellType: ColorToggleButtonCell.self
            )) { index, category, cell in
                cell.configure(category: category)
                self.cellsList.insert(cell, at: index)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpBinding() {
        
        // 모임 카테고리를 선택하는 이벤트
        let selectClubCategory = categoryCollectionView.rx.modelSelected(BookClubCategory.self).asObservable()

        // MARK: Input
        let input = MainPageClubCategoryViewModel.Input(clubCategorySelectEvent: selectClubCategory)
        
        // MARK: Output
        let output = viewModel?.transform(input: input)
        
        
        
        output?.selectedClubCategory
            .bind{ [weak self] selectClubCategories in
                guard let cellsList = self?.cellsList else { return }
                for cell in cellsList {
                    guard let category = cell.category else { return }
                    if let _ = selectClubCategories.firstIndex(of: category) {
                        cell.makeButton(status: true)
                    }
                    else {
                        cell.makeButton(status: false)
                    }
                }
                self?.categoryCollectionView.reloadInputViews()
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpLayout() {
        [
            categoryCollectionView
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}

extension BookClubCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: ColorToggleButtonCell.id, for: indexPath) as? ColorToggleButtonCell else { return .zero }
        let item = BookClubCategory.allCases[indexPath.item]
        cell.colorButton.titleLabel!.text = item.toKorean
        let width = (cell.colorButton.titleLabel?.intrinsicContentSize.width ?? 64) + 20
        let height = (cell.colorButton.titleLabel?.intrinsicContentSize.height ?? 18) + 10
        let size = CGSize(width: width, height: height)
        
        return size
        }
}

@available(iOS 17.0, *)
#Preview {
    BookClubCategoryView()
}

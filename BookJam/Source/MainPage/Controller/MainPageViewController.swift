//
//  MainPageViewController.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit
import SnapKit
import RxSwift

enum mainPageSection: Hashable {
//    case adBanner // 광고 탭 섹션 (미정)
    case topView // 검색 버튼 + 카테고리 3개 버튼 섹션
    case content // 해당 내용 목록 섹션
}

enum mainPageItem: Hashable {
//    case adBanner
    case topView // 검색버튼 + 카테고리 버튼 3개
    case bookPlace(Place) // 독립서점
    case bookClub(BookClub) // 독서모임
    case publication(Book) // 출판물
}

final class MainPageViewController: UIViewController {
    
    // MARK: Variables
    
    /// Rx - DisposeBag
    private var disposeBag = DisposeBag()
    
    /// Rx - ViewModel
    private var viewModel = MainPageViewModel()
    
    /// Rx - topView 카테고리 선택 to MainPageCollectionHeaderViewModel
    private let selectCategory = PublishSubject<Category>()
    
    /// Rx - HeaderView Filter 선택 from MainPageCollectionHeaderViewModel
    private let selectFilter = PublishSubject<CombinedSearchFilter>()
   
    
    
    
    /// 상단 검색 버튼 + 카테고리 3개버튼 포함한 뷰
//    private lazy var topView = MainPageTopView() // -> 여기에 검색탭 + 카테고리 3개 넣는 View
    
    /// 메인 컨텐츠 목록 보여주는 콜렉션 뷰
    private lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .gray
        $0.register(MainPageTopView.self, forCellWithReuseIdentifier: MainPageTopView.id) // 섹션 상단 검색탭 + 카테고리 3개 넣는 View
        $0.register(BookStoreCollectionViewCell.self, forCellWithReuseIdentifier: BookStoreTableViewCell.cellID) // 섹션 콜렉션뷰 셀
        $0.register(MainPageCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPageCollectionHeaderView.id)// 섹션헤더
    }
    
    private var mainDataSource: UICollectionViewDiffableDataSource<mainPageSection,mainPageItem>?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpBinding()
        setUpLayout()
        setUpConstraint()
        setDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<mainPageSection,mainPageItem>()
        let items: [mainPageItem] = [mainPageItem.bookPlace(Place(placeId: 0, name: "asdf", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205"))),
                                     mainPageItem.bookPlace(Place(placeId: 0, name: "gre", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205"))),
                                     mainPageItem.bookPlace(Place(placeId: 0, name: "tjhr", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205")))]
        
        let topSection = mainPageSection.topView
        let bottomSection = mainPageSection.content
    
        snapshot.appendSections([topSection])
        snapshot.appendItems([mainPageItem.topView], toSection: topSection)
        
        snapshot.appendSections([bottomSection])
        snapshot.appendItems(items, toSection: bottomSection)
        mainDataSource?.apply(snapshot)
    }
    
    // MARK: Configure View
    private func setUpView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Data Binding
    private func setUpBinding() {
        // MARK: Input
        let input = MainPageViewModel.Input(
            categoryTrigger: self.selectCategory.asObservable(),
            selectFilter: self.selectFilter.asObservable()
        )
        
        // MARK: Output
        let output = viewModel.transform(input: input)
        
//        output.selectedCategory // topview에 디자인 연결
//        
//        output.selectedFilter // headerview에 목록 연결

    }
    
    // MARK: Layout
    private func setUpLayout() {
        [
            mainCollectionView
        ].forEach { self.view.addSubview($0)}
    }
    
    
    // MARK: Constraint
    private func setUpConstraint() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

// MARK: UICollecitonView Compositional Layout
extension MainPageViewController {
    
    // MARK: Section Layout을 포함한 Compositional Layout return
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10 // section Spacing
        config.scrollDirection = .vertical
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            // mainDataSource에서 관리되는 sectionIdentifier에만 대응하여 return
            
            let section = self?.mainDataSource?.sectionIdentifier(for: sectionIndex)

            switch section {
//            case.adBanner:
//                return someSection
            case .topView:
                return self?.createTopViewSection()
            case .content:
                return self?.createContentSection()
                
            default : // 둘 다 해당되지 않는 경우 + section 캐스팅 실패
                return self?.createTopViewSection()
            }
        }, configuration: config)
    }
    
    // MARK: 검색버튼 + 카테고리 버튼 3개 포함한 상단 뷰 Section Layout 생성
    private func createTopViewSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: 카테고리 메인 결과 뷰 Section Layout 생성
    private func createContentSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(240))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(240))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: UICollectionView Diffable DataSource
extension MainPageViewController: UICollectionViewDelegate {
    
    // Diffable DataSource 설정
    private func setDataSource() {
        // 셀 설정
        mainDataSource = UICollectionViewDiffableDataSource<mainPageSection,mainPageItem>(collectionView: mainCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) in
            
            switch itemIdentifier {
            case .topView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageTopView.id, for: indexPath) as? MainPageTopView else { return UICollectionViewCell() }
                
                cell.categorySelectEvent
                    .bind(to: self.selectCategory)
                    .disposed(by: self.disposeBag)
                        
                return cell
                
            case .bookPlace(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookStoreCollectionViewCell.cellID, for: indexPath) as? BookStoreCollectionViewCell else { return UICollectionViewCell() }
                cell.cellModel = data
                return cell
                
            // Cell 수정 필요
            case .bookClub(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookStoreCollectionViewCell.cellID, for: indexPath) as? BookStoreCollectionViewCell else { return UICollectionViewCell() }
//                cell.cellModel = data
                return cell
                
            // Cell 수정 필요
            case .publication(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookStoreCollectionViewCell.cellID, for: indexPath) as? BookStoreCollectionViewCell else { return UICollectionViewCell() }
//                cell.cellModel = data
                return cell
            }
        })
        
        // 헤더 뷰 설정
        mainDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPageCollectionHeaderView.id, for: indexPath) as? MainPageCollectionHeaderView else { return UICollectionReusableView() }
                
            // 여기에서 ViewModel의 state 참조 - Viewmodel 필요
            
            // HeaderView -> MainPage
//            header.filterSelectEvent
//                .subscribe(onNext: {
//                    print($0.inKorean)
//                }, onError: {
//                    print($0.localizedDescription)
//                }, onCompleted: {
//                    print("com")
//                }, onDisposed: {
//                    print("dis")
//                })
//                .disposed(by: self.disposeBag)
            
            self.selectFilter
                .bind(to: header.filterSelectEvent)
                .disposed(by: self.disposeBag)
            
            // MainPage -> HeaderView
            self.selectCategory
                .bind(to: header.selectedCategory)
                .disposed(by: self.disposeBag)
            
            return header
        }
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        // section으로 접근
//        guard let section = mainDataSource?.sectionIdentifier(for: indexPath.section) else { return }
//        
//        switch section {
//            
//        case .adBanner:
//            <#code#>
//        case .topView:
//            <#code#>
//        case .content:
//            <#code#>
//        }
//
//        
//        // item으로 접근
//        guard let selectedItem = mainDataSource?.itemIdentifier(for: indexPath) else { return }
//        
//        switch selectedItem {
//            
//        case .bookPlace(_):
//            <#code#>
//        case .bookClub(_):
//            <#code#>
//        case .publication(_):
//            <#code#>
//        }
         
//         //check whether there was another item already selected in this section
//         if let nameOfCurrentlySelectedItemInThisSection = stateTracker[indexPath.section] {
//             //we need to unselect this item, get its indexpath from the other tracker
//             if let indexPathToDeselect = indexPathTracker[nameOfCurrentlySelectedItemInThisSection] {
//                 collectionView.deselectItem(at: indexPathToDeselect, animated: false)
//             }
//         }

        
         // update the trackers
//         stateTracker[indexPath.section] = selectedItem.name
//         indexPathTracker[selectedItem.name] = indexPath
     }
}

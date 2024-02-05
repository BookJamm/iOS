//
//  SearchPageViewController.swift
//  BookJam
//
//  Created by 박민서 on 2/5/24.
//

import UIKit
import SnapKit
import Then
import RxSwift


enum searchPageSection: Hashable {
    case topIndicatorView // 검색결과 개수 탑뷰 섹션
    case wholeView // 기본, 결과없음의 전체화면 섹션
    case bookPlace // 독립서점 섹션
    case bookClub // 모임 섹션
    case publication // 출판물 섹션
    
    // 헤더 타이틀용
    var sectionTitle: String {
        switch self {
        case .bookPlace:
            return "독립 서점"
        case .bookClub:
            return "모임"
        case .publication:
            return "출판물"
        default:
            return ""
        }
    }
}

enum searchPageItem: Hashable {
    case topIndicatorView // 검색결과 개수 탑뷰
    case wholeView // 전체화면
    case bookPlace(Place) // 독립서점
    case bookClub(BookClub) // 독서모임
    case publication(Book) // 출판물
}

final class SearchPageViewController: UIViewController {
    
    // MARK: Variables
    
    /// Rx - DisposeBag
    private var disposeBag = DisposeBag()
    
    /// Rx - ViewModel
    private var viewModel = MainPageViewModel()
    
    private lazy var searchBar = SearchPageSearchBar().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// 검색 컨텐츠 보여주는 콜렉션 뷰
    private lazy var searchCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .gray01
        

        $0.register(SearchPageBackgroundViewCell.self, forCellWithReuseIdentifier: SearchPageBackgroundViewCell.id) // 뒷 배경 상태 셀
        $0.register(SearchPageResultCountViewCell.self, forCellWithReuseIdentifier: SearchPageResultCountViewCell.id) // 검색 결과 상단 결과 수 셀
        $0.register(BookStoreCollectionViewCell.self, forCellWithReuseIdentifier: BookStoreCollectionViewCell.cellID) // 독립서점 셀
        $0.register(BookClubCollectionViewCell.self, forCellWithReuseIdentifier: BookClubCollectionViewCell.id) // 모임 셀
        $0.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: PublicationCollectionViewCell.id) // 출판물 셀
        $0.register(SearchPageCollecionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchPageCollecionHeaderView.id) // 섹션헤더

    }
    
    private var searchDataSource: UICollectionViewDiffableDataSource<searchPageSection,searchPageItem>?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        setDataSource()
        setUpBinding()
        
        var snapshot = NSDiffableDataSourceSnapshot<searchPageSection,searchPageItem>()
        
        let sec0 = searchPageSection.wholeView
        let sec1 = searchPageSection.topIndicatorView
        let sec2 = searchPageSection.bookPlace
        let sec3 = searchPageSection.bookClub
        let sec4 = searchPageSection.publication
        

        
//        snapshot.appendSections([sec0])
//        snapshot.appendItems([searchPageItem.wholeView], toSection: sec0)
        
                snapshot.appendSections([sec1])
                snapshot.appendItems([searchPageItem.topIndicatorView], toSection: sec1)
        
        let items2 = [Place(placeId: 0, name: "BookStore1", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                     Place(placeId: 1, name: "BookStore2", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil)].map { place in
            return searchPageItem.bookPlace(place)}
        
        snapshot.appendSections([sec2])
        snapshot.appendItems(items2, toSection: sec2)
        
        let items3 = [BookClub(bookClubID: 0, name: "BookClub2", date: nil, cover: nil, place: nil, type: nil),
                      BookClub(bookClubID: 1, name: "BookClub3", date: nil, cover: nil, place: nil, type: nil)].map { place in
            return searchPageItem.bookClub(place)}
        
        snapshot.appendSections([sec3])
        snapshot.appendItems(items3, toSection: sec3)
        
        let items4 = [Book(bookID: 0, place: nil, title: "Publication3", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                      Book(bookID: 1, place: nil, title: "Publication4", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)].map { place in
            return searchPageItem.publication(place)}
        
        snapshot.appendSections([sec4])
        snapshot.appendItems(items4, toSection: sec4)
        
        self.searchDataSource?.apply(snapshot)
    }
    
    // MARK: Configure View
    private func setUpView() {
        self.view.backgroundColor = .white
    }
    
    // MARK: Data Binding
    private func setUpBinding() {
        // MARK: Input
//        let input = MainPageViewModel.Input(
//            categoryTrigger: self.selectCategory.asObservable(),
//            selectFilter: self.selectFilter.asObservable()
//        )
        
        // MARK: Output
//        let output = viewModel.transform(input: input)
//        output.
//        output.selectedCategory // topview에 디자인 연결
//
//        output.selectedFilter // headerview에 목록 연결

    }
    
    // MARK: Layout
    private func setUpLayout() {
        [
            searchBar,
            searchCollectionView
        ].forEach { self.view.addSubview($0)}
    }
    
    
    // MARK: Constraint
    private func setUpConstraint() {
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
//            $0.bottom.equalToSuperview().offset(-12)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(1)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

// MARK: UICollecitonView Compositional Layout
extension SearchPageViewController {
    
    // MARK: Section Layout을 포함한 Compositional Layout return
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.interSectionSpacing = 1
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            
            let section = self?.searchDataSource?.sectionIdentifier(for: sectionIndex)

            switch section {
                
            case .topIndicatorView:
                return (self?.createTopIndicatorViewSection())!
            case .wholeView:
                return (self?.createWholeViewSection())!
            case .bookPlace, .bookClub, .publication:
                return (self?.createContentSection())!
                
            default : // 다 해당되지 않는 경우 + section 캐스팅 실패
                return self?.createTopIndicatorViewSection()
            }
        }, configuration: config)
    }
    
    // MARK: 검색 서치바 아래 검색 결과 수 Indicator View Section Layout 생성
    private func createTopIndicatorViewSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(42))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 1
        return section
    }
    
    // MARK: CollectionView 배경에 들어갈 전체 View Section Layout 생성
    private func createWholeViewSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: 메인 결과 뷰 Section Layout 생성
    private func createContentSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(240))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(240))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading, absoluteOffset: CGPoint(x: 0, y: 0))
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.interGroupSpacing = 1 // group 간 간격 설정
        return section
    }
}

// MARK: UICollectionView Diffable DataSource
extension SearchPageViewController: UICollectionViewDelegate {
    
    // Diffable DataSource 설정
    private func setDataSource() {
        // 셀 설정
        searchDataSource = UICollectionViewDiffableDataSource<searchPageSection,searchPageItem>(collectionView: searchCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) in
            
            switch itemIdentifier {
                
            case .topIndicatorView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPageResultCountViewCell.id, for: indexPath) as? SearchPageResultCountViewCell else { return UICollectionViewCell() }
                // viewModel Inject
                return cell
                
            case .wholeView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPageBackgroundViewCell.id, for: indexPath) as? SearchPageBackgroundViewCell else { return UICollectionViewCell() }
                return cell
                
            case .bookPlace(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookStoreCollectionViewCell.cellID, for: indexPath) as? BookStoreCollectionViewCell else { return UICollectionViewCell() }
                cell.cellModel = data
                return cell
                
            case .bookClub(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookClubCollectionViewCell.id, for: indexPath) as? BookClubCollectionViewCell else { return UICollectionViewCell() }
                cell.cellModel = data
                return cell
                
            case .publication(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicationCollectionViewCell.id, for: indexPath) as? PublicationCollectionViewCell else { return UICollectionViewCell() }
                cell.cellModel = data
                return cell
            }
        })
        
        // 헤더 뷰 설정
        searchDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchPageCollecionHeaderView.id, for: indexPath) as? SearchPageCollecionHeaderView else { return UICollectionReusableView() }

            // 여기에서 해당 cell의 이름이 필요함
            // 해당 section에 대한 데이터를 가져와서 헤더에 적용
            if let section = self.searchDataSource?.snapshot().sectionIdentifiers[indexPath.section] {
                header.configure(title: section.sectionTitle)
            }
            
            return header
        }
    }

}

@available(iOS 17.0,*)
#Preview {
    SearchPageViewController()
}

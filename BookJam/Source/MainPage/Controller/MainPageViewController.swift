////
////  MainPageViewController.swift
////  BookJam
////
////  Created by 박민서 on 12/24/23.
////
//
//import UIKit
//import SnapKit
//import RxSwift
//
//enum mainPageSection: Hashable {
//    case adBanner // 광고 탭 섹션 (미정)
//    case topView // 검색 버튼 + 카테고리 3개 버튼 섹션
//    case content // 해당 내용 목록 섹션
//}
//
//enum mainPageItem: Hashable {
//    case bookPlace(Place) // 독립서점
//    case bookClub(BookClub) // 독서모임
//    case publication(Book) // 출판물
//}
//
//final class MainPageViewController: UIViewController {
//    
//    // MARK: Variables
//    
//    /// Rx - DisposeBag
//    private var disposeBag = DisposeBag()
//    
//    /// MainPageViewController 뷰모델
////    private var viewModel
//    
//    
//    /// 상단 검색 버튼 + 카테고리 3개버튼 포함한 뷰
//    lazy var topView = UIView() // -> 여기에 검색탭 + 카테고리 3개 넣는 View
//    
//    /// 메인 컨텐츠 목록 보여주는 콜렉션 뷰
//    lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
//        $0.backgroundColor = .white
////        $0.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>) // 섹션 콜렉션뷰 셀
////        $0.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)// 섹션헤더
//    }
//    
//    private var mainDataSource: UICollectionViewDiffableDataSource<mainPageSection,mainPageItem>?
//    
//    // MARK: LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setUpView()
//        setUpBinding()
//        setUpLayout()
//        setUpConstraint()
//        
//    }
//    
//    // MARK: Configure View
//    private func setUpView() {
//        self.view.backgroundColor = .white
////        self.navigationController?.navigationBar.isHidden = true
//    }
//    
//    // MARK: Data Binding
//    private func setUpBinding() {
//        // MARK: Input
////        let input = LocationViewModel.Input(refreshTrigger: currentLocateBtn.rx.tap.asObservable())
//        
//        // MARK: Output
////        let output = viewModel.transform(input: input)
//        
//        
//    }
//    
//    // MARK: Layout
//    private func setUpLayout() {
//        [
//        ].forEach { self.view.addSubview($0)}
//    }
//    
//    
//    // MARK: Constraint
//    private func setUpConstraint() {
//        
//    }
//
//}
//
//// MARK: UICollecitonView Compositional Layout
//extension MainPageViewController {
//    
//    // MARK: Section Layout을 포함한 Compositional Layout return
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        
//        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
//            // mainDataSource에서 관리되는 sectionIdentifier에만 대응하여 return
//            let section = self?.mainDataSource?.sectionIdentifier(for: sectionIndex)
//            switch section {
////            case.adBanner:
////                return someSection
//            case .topView:
//                return self?.createTopViewSection()
//            case .content:
//                return self?.createContentSection()
//            default:
////                return NSCollectionLayoutSection(group: <#T##NSCollectionLayoutGroup#>)
//                return self?.createTopViewSection()
//            }
//        }, configuration: config)
//    }
//    
//    // MARK: 검색버튼 + 카테고리 버튼 3개 포함한 상단 뷰 Section Layout 생성
//    private func createTopViewSection() -> NSCollectionLayoutSection {
//        // item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        // group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
////        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        // section
//        let section = NSCollectionLayoutSection(group: group)
//        return section
//    }
//    
//    // MARK: 카테고리 메인 결과 뷰 Section Layout 생성
//    private func createContentSection() -> NSCollectionLayoutSection {
//        // item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(320))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        // group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
////        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        // section
//        let section = NSCollectionLayoutSection(group: group)
//        return section
//    }
//}
//
//// MARK: UICollectionView Diffable DataSource
//extension MainPageViewController {
//    private func setDataSource() {
//        mainDataSource = UICollectionViewDiffableDataSource<mainPageSection,mainPageItem>(collectionView: mainCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) in
//            switch itemIdentifier {
//            case .bookPlace(let data):
////                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
////                cell.config(data)
////                return cell
//                break
//            case .bookClub(let data):
////                            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
////                            cell.config(data)
////                            return cell
//                break
//            case .publication(let data):
////                            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
////                            cell.config(data)
////                            return cell
//                break
//            }
//        })
//        
//        mainDataSource?.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView in
//        }
//    }
//}

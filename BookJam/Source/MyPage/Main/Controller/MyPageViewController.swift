//
//  MyPageViewController.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import UIKit
import SnapKit
import Then
import RxSwift


enum MyPageSection: Hashable {
    case topProfile // 상단 프로필 섹션
    case myBookLife // 나의 독서생활 섹션
    case myInfo // 나의 정보 섹션
    case manageAccount // 계정 관리 섹션
    
    // 헤더 타이틀용
    var sectionTitle: String? {
        switch self {
        case .topProfile:
            return nil
        case .myBookLife:
            return "나의 독서생활"
        case .myInfo:
            return "나의 정보"
        case .manageAccount:
            return "계정 관리"
        }
    }
}

enum MyPageItem: Hashable {
    case topProfile // 상단 프로필
    case myBookLife(MyPageListCellType) // 나의 독서생활
    case myInfo(MyPageListCellType) // 나의 정보
    case manageAccount(MyPageListCellType) // 계정 관리
}

final class MyPageViewController: UIViewController {
    
    // MARK: Variables
    
    /// Rx - DisposeBag
    private var disposeBag = DisposeBag()
    
    /// Rx - ViewModel
//    private var viewModel = SearchPageViewModel()
    
    /// 상단 "마이페이지" 탭 배경 뷰
    private lazy var topBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    /// "마이페이지" 타이틀 라벨
    private var topBarTitleLabel: UILabel = UILabel().then {
        $0.text = "마이페이지"
        $0.font = paragraph01
        $0.textColor = .black
    }
    
    /// 마이 페이지 컨텐트 목록 보여주는 콜렉션 뷰
    private lazy var myPageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .gray01
        
        $0.register(MyPageProfileViewCell.self, forCellWithReuseIdentifier: MyPageProfileViewCell.id) // 상단 프로필 셀
        $0.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.id) // 각 목록 아이템에 해당하는 셀
        $0.register(MyPageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyPageHeaderView.id) // 각 목록 섹션 헤더
    }
    
    private var myPageDataSource: UICollectionViewDiffableDataSource<MyPageSection,MyPageItem>?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        setDataSource()
        setUpBinding()
        
        let myBookLifeList:[MyPageItem] = [
            .participatedActivityStatus,
            .markedActivities
        ].map { return MyPageItem.myBookLife($0)}
        
        let myInfoList:[MyPageItem] = [
            .changeProfileOrNickname,
            .changePassword,
            .changeNotificationSetting
        ].map { return MyPageItem.myInfo($0)}
        
        let manageAccList:[MyPageItem] = [
            .userInquiry,
            .logout,
            .accountTermination
        ].map { return MyPageItem.manageAccount($0)}
        
        var snapshot = NSDiffableDataSourceSnapshot<MyPageSection,MyPageItem>()
        snapshot.appendSections([.topProfile, .myBookLife, .myInfo, .manageAccount])
        snapshot.appendItems([.topProfile], toSection: .topProfile)
        snapshot.appendItems(myBookLifeList, toSection: .myBookLife)
        snapshot.appendItems(myInfoList, toSection: .myInfo)
        snapshot.appendItems(manageAccList, toSection: .manageAccount)
        self.myPageDataSource?.apply(snapshot)
        
    }
    
    // MARK: Configure View
    private func setUpView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Data Binding
    private func setUpBinding() {

    }
    
    // MARK: Layout
    private func setUpLayout() {
        
        topBarView.addSubview(topBarTitleLabel)
        
        [
            topBarView,
            myPageCollectionView
        ].forEach { self.view.addSubview($0)}
    }
    
    
    // MARK: Constraint
    private func setUpConstraint() {
        
        topBarTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(20).priority(.low)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        topBarView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        myPageCollectionView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(1)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}


// MARK: UICollecitonView Compositional Layout
extension MyPageViewController {
    
    // MARK: Section Layout을 포함한 Compositional Layout return
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.interSectionSpacing = 10
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            
            let section = self?.myPageDataSource?.sectionIdentifier(for: sectionIndex)

            switch section {
                
            case .topProfile:
                return self?.createTopProfileViewSection()
            case .myBookLife, .myInfo, .manageAccount:
                return self?.createContentSection()
            default : // 다 해당되지 않는 경우 + section 캐스팅 실패
                return self?.createContentSection()
            }
        }, configuration: config)
    }
    
    // MARK: 상단 탭바 아래 topProfile View Section Layout 생성
    private func createTopProfileViewSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 1
        return section
    }
    
    // MARK: myBookLife, myInfo, manageAccount Section Layout 생성
    private func createContentSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(56))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading, absoluteOffset: CGPoint(x: 0, y: 0))
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: UICollectionView Diffable DataSource
extension MyPageViewController: UICollectionViewDelegate {
    
    // Diffable DataSource 설정
    private func setDataSource() {
        // 셀 설정
        myPageDataSource = UICollectionViewDiffableDataSource<MyPageSection,MyPageItem>(collectionView: myPageCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) in
            
            switch itemIdentifier {
                
            case .topProfile:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageProfileViewCell.id, for: indexPath) as? MyPageProfileViewCell else { return UICollectionViewCell() }
                // cell configure 필요
                return cell
                
            case .myBookLife(let type), .myInfo(let type), .manageAccount(let type) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.id, for: indexPath) as? MyPageCollectionViewCell else { return UICollectionViewCell() }
                print(type)
                cell.configure(type: type)
                return cell
            }
        })
        
        // 헤더 뷰 설정
        myPageDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPageHeaderView.id, for: indexPath) as? MyPageHeaderView else { return UICollectionReusableView() }

            if let section = self.myPageDataSource?.snapshot().sectionIdentifiers[indexPath.section] {
                if section != MyPageSection.topProfile {
                    header.configure(title: section.sectionTitle ?? "")
                }
            }
            return header
        }
    }

}

@available(iOS 17.0,*)
#Preview {
    MyPageViewController()
}

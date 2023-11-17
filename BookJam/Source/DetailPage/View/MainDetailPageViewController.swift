//
//  MainDetailPageViewController.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

//디테일 페이지 섹션 레이아웃
enum DetailSection: Hashable {
    case Home
    case Review
    case Activity
    case News
    case BookList
}

//디테일 페이지 셀
enum Item: Hashable {
    case ReviewItem(PlaceIdReviewsResponseModel)
    case ActivityItem(Activities)
    case NewsItem(PlaceIdNewsResponseModel)
    case BookListItem(PlaceIdBooksResponseModel)
}

@available(iOS 16.0, *)
class MainDetailPageViewController: UIViewController {
    
    // MARK: Variables
    private var dataSource: UICollectionViewDiffableDataSource<DetailSection, Item>?
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.register(BookNewsCollectionViewCell.self, forCellWithReuseIdentifier: BookNewsCollectionViewCell.id)
        $0.register(BookActivityCollectionViewCell.self, forCellWithReuseIdentifier: BookActivityCollectionViewCell.id)
        $0.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.id)
        $0.register(BookReviewCollectionViewCell.self, forCellWithReuseIdentifier: BookReviewCollectionViewCell.id)
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
    }
    
    
    let topView = MainDetailTopView()
    let segmentedControl = MainDetailSegmentedControl(items: ["홈", "소식", "참여", "리뷰", "책 종류"])
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        //        setUpLayout()
        setUpConstraint()
        setDatasource()
        setSnapShot()
        //        setUpDelegate()
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        self.view.addSubview(topView)
        self.view.addSubview(collectionView)
        self.view.addSubview(segmentedControl)
        
        topView.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(450)
        }
        
        segmentedControl.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(topView.snp.bottom)
        }
        collectionView.snp.makeConstraints{
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(segmentedControl.snp.bottom)
            
        }
    }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        
    }
    
    // MARK: Delegate
    
    func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<DetailSection, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .ActivityItem(let contentData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookActivityCollectionViewCell.id, for: indexPath) as? BookActivityCollectionViewCell
//                cell?.configure(title: contentData.title, review: contentData.vote, desc: contentData.overview, imageURL: contentData.posterURL)
                cell?.configure(title: contentData.title, url: contentData.imageUrl!)
                print("Activity Item 데이터소스 등록")
                return cell!
            case .BookListItem(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.id, for: indexPath) as? BookListCollectionViewCell
//                cell?.configure(title: movieData.title, overview: movieData.overview, review: movieData.vote, url: movieData.posterUrl)
                return cell!
            case .NewsItem(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookNewsCollectionViewCell.id, for: indexPath) as? BookNewsCollectionViewCell
                cell?.configure(title: movieData.title!, content: movieData.contents!)
                print("News Item 데이터소스 등록")
                return cell!
            case .ReviewItem(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookReviewCollectionViewCell.id, for: indexPath) as? BookReviewCollectionViewCell
//                cell?.configure(title: movieData.title, releaseDate: movieData.releaseDate, url: movieData.posterUrl)
                return cell!
            }
        })
        
        //Header 설정
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath ->
        UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
//            switch section {
//            case .horizontal(let title), .vertical(let title):
//                (header as? HeaderView)?.configure(title: title)
//                
//            default:
//                print("Default")
//            }
            
            return header
        }
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, Item>()
        
        let section = DetailSection.Activity
        snapshot.appendSections([section])
        
        // 기본값으로 사용할 데이터 생성 (실제 데이터를 사용하도록 변경하세요)
        let defaultActivityData = Activities(activityId: 1, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let defaultActivityData1 = Activities(activityId: 2, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
            
        let defaultActivityData3 = Activities(activityId: 3, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let defaultActivityData4 = Activities(activityId: 4, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let bannerItems = [
            Item.ActivityItem(defaultActivityData),
            Item.ActivityItem(defaultActivityData1),
            Item.ActivityItem(defaultActivityData3),
            Item.ActivityItem(defaultActivityData4),
        ]
            
        snapshot.appendItems(bannerItems, toSection: section)
        
//        self.dataSource?.apply(snapshot)
        
        let section1 = DetailSection.News
        snapshot.appendSections([section1])
        
        let defailtNewsData = PlaceIdNewsResponseModel(newsId: 1, createdAt: "2022", updatedAt: "2022", title: "NEws", contents: "뉴스 내용입니다", placeId: 1)
        let bannerItems1 = [
            Item.NewsItem(defailtNewsData)
        ]
        snapshot.appendItems(bannerItems1, toSection: section1)
        
        self.dataSource?.apply(snapshot)
        
        print("Snapshot 함수 완료")
    }
    

    // MARK: Function
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .Home:
                return self!.createHomeSection()
            case .News:
                print("뉴스 레이아웃 생성")
                return self?.createNewsSection()
            case .Activity:
                print("액티비티 레이아웃 생성")
                return self?.createActivitySection()
            case .Review:
                return self?.createReviewSection()
            case .BookList:
                return self?.createBookListSection()
            default:
                return self!.createActivitySection()
            }
        }, configuration: config)
    }//end of createLayout()
    
    private func createHomeSection() -> NSCollectionLayoutSection{//홈 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createNewsSection() -> NSCollectionLayoutSection {//소식 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createActivitySection() -> NSCollectionLayoutSection {//참여 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.38), heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createReviewSection() -> NSCollectionLayoutSection {//리뷰 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createBookListSection() -> NSCollectionLayoutSection {//책 종류 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
}

import SwiftUI
@available(iOS 16.0, *)
struct MainDetailPageViewController_Preview: PreviewProvider {
    static var previews: some View {
        MainDetailPageViewController().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}

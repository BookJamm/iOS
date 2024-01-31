//
//  MainDetailHomeTabTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/3/23.
//

import UIKit
import RxSwift

// 메인디테일 홈탭에 보여질 테이블뷰 셀입니다.
@available(iOS 16.0, *)
class MainDetailHomeTabTableViewCell: UITableViewCell {

    // MARK: Variables
    
    static let id = "MainDetailHomeTabCell"
    private var dataSource: UICollectionViewDiffableDataSource<DetailSection, DetailItem>?
    
    var disposeBag = DisposeBag()

    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        // HomwCell, EventCell, participantCell,,, 5개
        
        $0.register(BookNewsCollectionViewCell.self, forCellWithReuseIdentifier: BookNewsCollectionViewCell.id)
        $0.register(BookActivityCollectionViewCell.self, forCellWithReuseIdentifier: BookActivityCollectionViewCell.id)
        $0.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.id)
        $0.register(BookReviewCollectionViewCell.self, forCellWithReuseIdentifier: BookReviewCollectionViewCell.id)
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            
            disposeBag = DisposeBag() // 셀이 재사용될 때마다 새 DisposeBag을 생성합니다.
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setDatasource()
        setUpConstraint()
        setSnapShot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(homeAllList: Observable<DetailHomeTabModel>) {
        print("bindViewModel 함수 실행")
        homeAllList
            .subscribe(onNext: { [weak self] homeAllList in
                self?.updateSnapshot(section: .News("\(String(describing: homeAllList.homeList.name))의 소식"), items: homeAllList.newsList.map { DetailItem.NewsItem($0) })
                self?.updateSnapshot(section: .BookList, items: homeAllList.bookList.map { DetailItem.BookListItem($0) })
                self?.updateSnapshot(section: .Activity, items: homeAllList.activityList.map { DetailItem.ActivityItem($0) })
                self?.updateSnapshot(section: .Review, items: homeAllList.reviewList.map { DetailItem.ReviewItem($0) })
            })
            .disposed(by: disposeBag)
    }
    

    private func updateSnapshot(section: DetailSection, items: [DetailItem]) {
        print("\(section) 업데이트 스냅샷")
        var snapshot = dataSource?.snapshot() ?? NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()

        if snapshot.sectionIdentifiers.contains(section) {
            // 섹션의 모든 아이템을 삭제합니다.
            print("올드 아이템 제거")
            let oldItems = snapshot.itemIdentifiers(inSection: section)
            snapshot.deleteItems(oldItems)
        } else {
            // 새로운 섹션을 추가합니다.
            print("새로운 섹션 추가")
            snapshot.appendSections([section])
        }

        // 새 아이템을 추가합니다.
        snapshot.appendItems(items, toSection: section)

        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }

    // MARK: Constraint
    func setUpConstraint() {
        
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    
    func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<DetailSection, DetailItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .ActivityItem(let contentData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookActivityCollectionViewCell.id, for: indexPath) as? BookActivityCollectionViewCell
//                cell?.configure(title: contentData.title, review: contentData.vote, desc: contentData.overview, imageURL: contentData.posterURL)
                cell?.configure(title: contentData.title, url: contentData.imageUrl!)
                print("Activity Item 데이터소스 등록")
                return cell!
            case .BookListItem(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.id, for: indexPath) as? BookListCollectionViewCell
                cell?.configure(url: movieData.cover!, title: movieData.title!, author: movieData.author!, publish: movieData.publisher!)
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
            case .homeItem(_):
                return UICollectionViewCell()
            }
        })
        
        //Header 설정
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath ->
        UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .News(let title):
                (header as? HeaderView)?.configure(title: "\(title)의 소식")
            case .BookList:
                (header as? HeaderView)?.configure(title: "책 목록")
            case .Activity:
                (header as? HeaderView)?.configure(title: "추천 모임")
            case .Review:
                (header as? HeaderView)?.configure(title: "리뷰")
            default:
                print("Default")
            }
            
            return header
        }
    }
    
     func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
        //소식
        let section1 = DetailSection.News("임시")
        snapshot.appendSections([section1])
        
        let defailtNewsData = News(newsId: 1, createdAt: "2022", updatedAt: "2022", title: "NEws", contents: "뉴스 내용입니다", placeId: 1)
        let bannerItems1 = [
            DetailItem.NewsItem(defailtNewsData)
        ]
        snapshot.appendItems(bannerItems1, toSection: section1)
        
        //책 목록
        let section2 = DetailSection.BookList
        snapshot.appendSections([section2])
        let bookData = DetailItem.BookListItem(Book(title: "진격거", author: "에렌 예거", cover: "https://image.aladin.co.kr/product/26/0/cover500/s742633278_1.jpg", isbn: "", description: "진격의 거인", publisher: "출판사"))
        let bookData1 = DetailItem.BookListItem(Book(title: "진격거2", author: "에렌 예거", cover: "https://image.aladin.co.kr/product/26/0/cover500/s742633278_1.jpg", isbn: "", description: "진격의 거인", publisher: "출판사"))
        let bookData2 = DetailItem.BookListItem(Book(title: "진격거3", author: "에렌 예거", cover: "https://image.aladin.co.kr/product/26/0/cover500/s742633278_1.jpg", isbn: "", description: "진격의 거인", publisher: "출판사"))
        
        let bookItems = [
            bookData,
            bookData1,
            bookData2
        ]
        snapshot.appendItems(bookItems, toSection: section2)
        
        // 독서 활동
        let section = DetailSection.Activity
        snapshot.appendSections([section])
        let defaultActivityData = Activity(activityId: 1, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let defaultActivityData1 = Activity(activityId: 2, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
            
        let defaultActivityData3 = Activity(activityId: 3, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let defaultActivityData4 = Activity(activityId: 4, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
        let bannerItems = [
            DetailItem.ActivityItem(defaultActivityData),
            DetailItem.ActivityItem(defaultActivityData1),
            DetailItem.ActivityItem(defaultActivityData3),
            DetailItem.ActivityItem(defaultActivityData4),
        ]
            
        snapshot.appendItems(bannerItems, toSection: section)
        
        let section3 = DetailSection.Review
        snapshot.appendSections([section3])
        let reviewItem = DetailItem.ReviewItem(Review(reviewId: 1, visitedAt: "2022 03 05", contents: "인테리어도 좋고 귀여운 아이템들도 있어서 아주 좋아요", rating: 5.0, images: [Image(id: 1, url: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")], author: Author(userId: 1, username: "독서 광인", profileImage: nil)))
        snapshot.appendItems([reviewItem], toSection: section3)
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createBookListSection() -> NSCollectionLayoutSection {//책 종류 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(275))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

@available(iOS 16.0, *)
extension MainDetailHomeTabTableViewCell: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0{
            print("CollectionView is scrolling")

        }
    }
}
#if DEBUG
import SwiftUI

@available(iOS 16.0, *)
struct MainDetailHomeTabTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailHomeTabTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

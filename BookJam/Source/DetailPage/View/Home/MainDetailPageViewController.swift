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
    case News(String)
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
final class MainDetailPageViewController: UIViewController {
    
    // MARK: Variables
    private var dataSource: UICollectionViewDiffableDataSource<DetailSection, Item>?
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        // HomwCell, EventCell, participantCell,,, 5개
        
        $0.register(BookNewsCollectionViewCell.self, forCellWithReuseIdentifier: BookNewsCollectionViewCell.id)
        $0.register(BookActivityCollectionViewCell.self, forCellWithReuseIdentifier: BookActivityCollectionViewCell.id)
        $0.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.id)
        $0.register(BookReviewCollectionViewCell.self, forCellWithReuseIdentifier: BookReviewCollectionViewCell.id)
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
    }
        
    let topView = MainDetailTopView()
    
//    let newsView = MainDetailNewsUIView()
    
    let segmentedControl = MainDetailSegmentedControl(items: ["홈", "소식", "참여", "리뷰", "책 종류"])
    
//    var shouldHideFirstView: Bool? {
//        didSet {
//          guard let shouldHideFirstView = self.shouldHideFirstView else { return }
//          self.collectionView.isHidden = shouldHideFirstView
//          self.newsView.isHidden = !self.collectionView.isHidden
//        }
//      }
    
//    var shouldHideFirstView: Bool = false {
//        didSet {
//            self.collectionView.isHidden = shouldHideFirstView
//            self.newsView.isHidden = !self.collectionView.isHidden
//        }
//    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        //        setUpLayout()
        setUpConstraint()
        setDatasource()
        setSnapShot()
        //        setUpDelegate()
        
//        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
//        
//        self.segmentedControl.selectedSegmentIndex = 0
//        self.didChangeValue(segment: self.segmentedControl)
        
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        self.view.addSubview(topView)
        self.view.addSubview(collectionView)
        self.view.addSubview(segmentedControl)
//        self.view.addSubview(newsView)
        
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
//        newsView.snp.makeConstraints{
//            $0.horizontalEdges.bottom.equalToSuperview()
//            $0.top.equalTo(segmentedControl.snp.bottom)
//        }
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
                (header as? HeaderView)?.configure(title: "독서 활동 참여 목록")
            case .Review:
                (header as? HeaderView)?.configure(title: "리뷰")
            default:
                print("Default")
            }
            
            return header
        }
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, Item>()
        
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
//            case .News:
//                print("뉴스 레이아웃 생성")
//                return self?.createNewsSection()
//            case .Activity:
//                print("액티비티 레이아웃 생성")
//                return self?.createActivitySection()
//            case .Review:
//                return self?.createReviewSection()
//            case .BookList:
//                return self?.createBookListSection()
            default:
                return self!.createHomeSection()
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
    
    
    
    //Segmented Control 클릭 시
//    @objc private func didChangeValue(segment: UISegmentedControl) {
//        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
//      }
    
}

import SwiftUI
@available(iOS 16.0, *)
struct MainDetailPageViewController_Preview: PreviewProvider {
    static var previews: some View {
        MainDetailPageViewController().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}

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
import RxDataSources

@available(iOS 16.0, *)
final class MainDetailPageViewController: UIViewController {
    
    // MARK: Variables
    
    private var viewModel = MainDetailPageViewModel()
    
    let disposeBag = DisposeBag()
    
    var topView = MainDetailTopView()
    
    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.register(MainDetailHomeTabTableViewCell.self, forCellReuseIdentifier: MainDetailHomeTabTableViewCell.id)
        $0.register(MainDetailNewsTableViewCell.self, forCellReuseIdentifier: MainDetailNewsTableViewCell.id)
        $0.register(MainDetailReviewTableViewCell.self, forCellReuseIdentifier: MainDetailReviewTableViewCell.id)
        $0.register(MainDetailActivityTableViewCell.self, forCellReuseIdentifier: MainDetailActivityTableViewCell.id)
        $0.register(MainDetailBookListTableViewCell.self, forCellReuseIdentifier: MainDetailBookListTableViewCell.id)
        $0.register(MainDetailHomeHeader.self, forHeaderFooterViewReuseIdentifier: MainDetailHomeHeader.id)
    }
    var innerScrollingDownDueToOuterScroll = false
    
    let homeTrigger = PublishSubject<Void>()
    let newsTrigger = PublishSubject<Void>()
    let activityTrigger = PublishSubject<Void>()
    let reviewTrigger = PublishSubject<Void>()
    let bookListTrigger = PublishSubject<Void>()
    
    lazy var input = MainDetailPageViewModel.Input(homeTrigger: homeTrigger.asObservable(), newsTrigger: newsTrigger.asObservable(), activityTrigger: activityTrigger.asObservable(), reviewTrigger: reviewTrigger.asObservable(), bookListTrigger: bookListTrigger.asObservable())
    
    lazy var output = viewModel.transform(input: input)
    
    var selectedSegmentIndex = 0    //현재 선택된 인덱스 저장하는 변수
    
    var dataSource: MainDetailDataSource!
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpConstraint()
        setUpDelegate()
        setUpDatasource()
        
        setUpBinding()
        homeTrigger.onNext(Void())
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        self.view.addSubview(tableView)
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 450))
        tableView.tableHeaderView?.addSubview(topView)
        topView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)
        
        tableView.snp.makeConstraints{
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalToSuperview()
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
    
    private func setUpDelegate() {
        
        tableView.delegate = self
    }
    
    // MARK: SetUpDataSource
    
    private func setUpDatasource() {
        self.dataSource = MainDetailDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item {
                
            case .homeItem(let homeAllList):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailHomeTabTableViewCell.id, for: indexPath) as! MainDetailHomeTabTableViewCell
                cell.bindViewModel(homeAllList: Observable.just(homeAllList))
                return cell
                
            case .NewsItem(let news):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailNewsTableViewCell.id, for: indexPath) as! MainDetailNewsTableViewCell
                cell.configure(title: news.title!, content: news.contents!, date: news.createdAt!)
                return cell
                
            case .ActivityItem(let activity):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailActivityTableViewCell.id, for: indexPath) as! MainDetailActivityTableViewCell
                cell.configure(url: activity.imageUrl!, title: activity.title, date: activity.createdAt!, location: activity.info)
                return cell
                
            case .ReviewItem(let review):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailReviewTableViewCell.id, for: indexPath) as! MainDetailReviewTableViewCell
                cell.configure(name: review.author.username!, contents: review.contents!, visitedAt: review.visitedAt!)
                return cell
                
            case .BookListItem(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailBookListTableViewCell.id, for: indexPath) as! MainDetailBookListTableViewCell
                
                return cell
            }
        })
    }
    
    // MARK: Data Binding
    private func setUpBinding() {
        output.homeAllList.bind { [weak self] homeAll in
            _ = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
            let items = homeAll.map { homeAllList in
                return DetailItem.homeItem(homeAllList)
            }

            self?.dataSource.update(section: DetailSection.Home, items: items)
            
//            self?.dataSource.apply(snapshot)
        }
        .disposed(by: disposeBag)
        
        output.newsList.bind { [weak self] newsList in
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
            let items = newsList.map { news in
                return DetailItem.NewsItem(news)
            }

            self?.dataSource.update(section: DetailSection.News("장모"), items: items)
            
        }
        .disposed(by: disposeBag)
        
        output.activityList.bind { [weak self] activityList in
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
            let items = activityList.map { activity in
                return DetailItem.ActivityItem(activity)
            }
            self?.dataSource.update(section: DetailSection.Activity, items: items)
        }
        .disposed(by: disposeBag)
        
        output.reviewList.bind { [weak self] reviewList in
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
            let items = reviewList.map { review in
                return DetailItem.ReviewItem(review)
            }
            self?.dataSource.update(section: DetailSection.Review, items: items)
        }
        .disposed(by: disposeBag)
        
        output.bookList.bind { [weak self] bookList in
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
            let items = bookList.map { book in
                return DetailItem.BookListItem(book)
            }
            self?.dataSource.update(section: DetailSection.BookList, items: items)
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: Function

    func updateTableViewUI(_ selectedIndex: Int) {
           // 선택된 인덱스에 따라 테이블 뷰의 UI를 업데이트하는 로직을 수행
           // 예를 들어, 데이터를 변경하고 다시 로드하는 등의 작업을 수행할 수 있음
           print("Selected index: \(selectedIndex)")
           // 여기서 필요한 로직을 구현하면 됩니다.
        
        switch selectedIndex {
        case 0:
            print("홈 탭 클릭")
            self.homeTrigger.onNext(Void())
        case 1:
            print("소식 탭 등록")
            self.newsTrigger.onNext(Void())
        case 2:
            print("참여 탭 클릭")
            self.activityTrigger.onNext(Void())
        case 3:
            print("리뷰 탭 클릭")
            self.reviewTrigger.onNext(Void())
        case 4:
            print("책 종류 클릭")
            self.bookListTrigger.onNext(Void())
        default:
            break
        }
       }
    
    
}//end of MainDetailPageViewController



@available(iOS 16.0, *)
extension MainDetailPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch selectedSegmentIndex {
        case 0:
            return 1000
        case 1: // 소식 탭
            return 122
        case 2: // 모임 탭
            return 152
        case 3: // 리뷰 탭
            return 254
        case 4: // 책 종류 탭
            return 134
        default:
            return 44 // 기본 셀 높이
        }
        
    }
    
    //헤더 등록 및 rx 바인딩
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainDetailHomeHeader.id) as! MainDetailHomeHeader
        
        header.segmentedControlValue
            .subscribe(onNext: { [weak self] selectedIndex in
                // selectedIndex를 사용하여 테이블 뷰의 UI 업데이트 로직을 수행
                self?.selectedSegmentIndex = selectedIndex
                self?.updateTableViewUI(selectedIndex)
            })
            .disposed(by: disposeBag)
        header.segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: 이중 스크롤 구현 부분
@available(iOS 16.0, *)
extension MainDetailPageViewController: UICollectionViewDelegate {
    private enum Policy {
            static let floatingPointTolerance = 0.1
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //innerScrollView
        
        let innerCellIndex = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: innerCellIndex) as? MainDetailHomeTabTableViewCell else {
            return
        }
        let innerScrollView = cell.collectionView
        
        let outerScroll = tableView == scrollView   // outerScrollView
        let innerScroll = innerScrollView == scrollView
        
        print("outerScroll: \(outerScroll), innerScroll: \(innerScroll)")

        let moreScroll = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
        let lessScroll = !moreScroll
        
//        let outerScrollMaxOffsetY = tableView.contentSize.height - tableView.frame.height
        let outerScrollMaxOffsetY = tableView.tableHeaderView?.frame.maxY

        let innerScrollMaxOffsetY = innerScrollView.contentSize.height - innerScrollView.frame.height

        if outerScroll && lessScroll {//외부 스크롤을 less 스크롤
            guard innerScrollView.contentOffset.y > 0 && tableView.contentOffset.y < outerScrollMaxOffsetY! else { return }
            innerScrollingDownDueToOuterScroll = true
            defer { innerScrollingDownDueToOuterScroll = false }
            
            // outer scroll에서 스크롤한 만큼 inner scroll에 적용
            innerScrollView.contentOffset.y = max(innerScrollView.contentOffset.y - (outerScrollMaxOffsetY! - tableView.contentOffset.y), 0)
            
            // outer scroll은 스크롤 되지 않고 고정
            tableView.contentOffset.y = outerScrollMaxOffsetY!
        }
        
        if innerScroll && moreScroll{//내부 스크롤을 more 스크롤
            
            guard
                tableView.contentOffset.y + Policy.floatingPointTolerance < outerScrollMaxOffsetY!,
                    !innerScrollingDownDueToOuterScroll
                else { return }
            
            // outer scroll를 more 스크롤
            let minOffetY = min(tableView.contentOffset.y + innerScrollView.contentOffset.y, outerScrollMaxOffsetY!)
            let offsetY = max(minOffetY, 0)
            tableView.contentOffset.y = offsetY
            
            // inner scroll은 스크롤 되지 않아야 하므로 0으로 고정
            innerScrollView.contentOffset.y = 0
        }
        
    }
}

//import SwiftUI
//@available(iOS 16.0, *)
//struct MainDetailPageViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        MainDetailPageViewController().toPreview()
//            //.edgesIgnoringSafeArea(.all)
//    }
//}

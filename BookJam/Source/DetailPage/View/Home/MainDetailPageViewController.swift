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



@available(iOS 16.0, *)
final class MainDetailPageViewController: UIViewController {
    
    // MARK: Variables
    
    private var viewModel = MainDetailPageViewModel()
    let disposeBag = DisposeBag()
    
    private var dataSource = [SettingSection]()
    
    var topView = MainDetailTopView()
    
    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.register(MainDetailHomeTabTableViewCell.self, forCellReuseIdentifier: MainDetailHomeTabTableViewCell.id)
        $0.register(MainDetailNewsTableViewCell.self, forCellReuseIdentifier: MainDetailNewsTableViewCell.id)
        
        $0.register(MainDetailHomeHeader.self, forHeaderFooterViewReuseIdentifier: MainDetailHomeHeader.id)
    }
    var innerScrollingDownDueToOuterScroll = false
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        //        setUpLayout()
        setUpConstraint()
        setSnapShot()
        setUpDelegate()
        
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, Item>()
    }
    

    // MARK: Function
    
    
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
    
    func updateTableViewUI(_ selectedIndex: Int) {
           // 선택된 인덱스에 따라 테이블 뷰의 UI를 업데이트하는 로직을 수행
           // 예를 들어, 데이터를 변경하고 다시 로드하는 등의 작업을 수행할 수 있음
           print("Selected index: \(selectedIndex)")
           // 여기서 필요한 로직을 구현하면 됩니다.
        
        tableView.beginUpdates()

        
        switch selectedIndex {
        case 1:

            print("소식 탭 등록")
            

        default:
            break
        }
        
        tableView.endUpdates()

       }
    
    
}

@available(iOS 16.0, *) // 이중 스크롤 구현
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

@available(iOS 16.0, *)
extension MainDetailPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 셀 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailHomeTabTableViewCell.id, for: indexPath) as! MainDetailHomeTabTableViewCell
        
        cell.selectionStyle = .none
        cell.collectionView.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 1000 //임시
        
    }
    
    //헤더 등록 및 rx 바인딩
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainDetailHomeHeader.id) as! MainDetailHomeHeader
        
        header.segmentedControlValue
            .subscribe(onNext: { [weak self] selectedIndex in
                // selectedIndex를 사용하여 테이블 뷰의 UI 업데이트 로직을 수행
                self?.updateTableViewUI(selectedIndex)
            })
            .disposed(by: disposeBag
            )
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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

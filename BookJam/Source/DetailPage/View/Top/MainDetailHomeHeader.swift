//
//  MainDetailHomeHeader.swift
//  BookJam
//
//  Created by 장준모 on 12/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainDetailHomeHeader: UITableViewHeaderFooterView {

    // MARK: Variables
    
    static let id = "MainDetailHomeHeader"
    
    var segmentedControl = MainDetailSegmentedControl()
    
    let segmentedControlValue = PublishSubject<Int>()

    let disposeBag = DisposeBag()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure() {
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    // MARK: View
    
    func setUpView() {
        // 세그먼티드 컨트롤 설정
        // ...
        
        // 세그먼티드 컨트롤 값 변경을 Subject에 바인딩
        segmentedControl.rx.selectedSegmentIndex
            .bind(to: segmentedControlValue)
            .disposed(by: disposeBag)
        
    }
    
    // MARK: Layout
    
    func setUpLayout() {
//        self.addSubview(segmentedControl)
        self.contentView.addSubview(segmentedControl)

    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        segmentedControl.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Function


}

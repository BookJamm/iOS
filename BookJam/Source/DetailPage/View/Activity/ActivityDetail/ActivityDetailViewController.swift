//
//  ActivityDetailViewController.swift
//  BookJam
//
//  Created by 장준모 on 2/10/24.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    // MARK: Variables
    
    let contentView = UIView().then{
        $0.backgroundColor = gray02
    }
    
    var activityTopView = ActivityTopView()
    
    var activityIntroduceView = ActivityIntroduceView()
    
    var scrollView: UIScrollView = UIScrollView().then{
        $0.backgroundColor = .white
    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        
        scrollView.updateContentSize()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .gray
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            scrollView,
        ].forEach{self.view.addSubview($0)}
        
        scrollView.addSubview(contentView)

        [
            activityTopView,
            activityIntroduceView
        ].forEach{contentView.addSubview($0)}    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(2000)
        }
        activityTopView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(611)
        }
        activityIntroduceView.snp.makeConstraints{
            $0.top.equalTo(activityTopView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(440)
        }
    }
    
    // MARK: Function


}

import SwiftUI
@available(iOS 16.0, *)
struct ActivityDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        ActivityDetailViewController().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}

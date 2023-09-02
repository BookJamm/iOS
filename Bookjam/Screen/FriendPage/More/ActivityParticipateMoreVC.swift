//
//  ActivityParticipateMoreVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/01.
//

import UIKit
import SwiftUI

class ActivityParticipateMoreVC: UIViewController {

    // MARK: Variables
    
    var dayLabel1: UILabel = UILabel().then{
        $0.text = "2023년 8월"
        $0.font = title06
    }
    
    var lastYearButton: UIButton = UIButton().then{
        $0.setTitle("작년 활동 현황 보기", for: .normal)
    }
    
    var tableView: UITableView = UITableView().then{
        $0.register(ActivityParticipateMoreTableViewCell.self, forCellReuseIdentifier: ActivityParticipateMoreTableViewCell().cellID)
        
    }
    
    // MARK: viewDidLoad()
    
     override func viewDidLoad() {
        super.viewDidLoad()

         setUpView()
         setUpLayout()
         setUpDelegate()
         setUpConstraint()
         
         tableView.tableFooterView = lastYearButton
     }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(tableView)
        tableView.addSubview(lastYearButton)
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(10)
            $0.height.equalTo(2000)
        }
    }
    
    // MARK: Function

}

extension ActivityParticipateMoreVC: UITableViewDelegate, UITableViewDataSource{
    
    // 섹션 수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityParticipateMoreTableViewCell().cellID, for: indexPath) as! ActivityParticipateMoreTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = gray01

        return cell
    }
    
    // 섹션 당 Header 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let headerLabel = UILabel().then{
            $0.text = "2023년 8월"
            $0.font = title06
            $0.frame = CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 30) // 헤더 높이 조절 가능
        }
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

struct ActivityParticipateMoreVC_Preview: PreviewProvider {
    static var previews: some View {
        ActivityParticipateMoreVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

//
//  ChoiceDateBottomSheetVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

// MARK: - 날짜 선택 화면에서 장소 방문 날짜 선택 버튼을 눌렀을 때 올라오는 달력 바텀시트

import SwiftUI
import UIKit

import SnapKit
import Then


class ChoiceDateBottomSheetVC: UIViewController {

    // MARK: Variables

    var calendarView: UIDatePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .inline
        $0.maximumDate = .now
        $0.timeZone = .current
        $0.tintColor = main03
    }
    
    var choiceButton : UIButton = UIButton().then {
        $0.backgroundColor = main03
        $0.setTitle("날짜 선택", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didChoiceButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            calendarView,
            choiceButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        choiceButton.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Function
    
    // 날짜 선택 버튼 눌렀을 때 방문 일자 버튼 업데이트되도록 설정
    @objc func didChoiceButtonTapped() {
        var dateForMatter = DateFormatter()
        dateForMatter.dateFormat = "yyyy.MM.dd"
        let date = dateForMatter.string(from: calendarView.date)
        
        // BookStoreChoiceDateVC().selectVisitDateButton.setTitle(date, for: .normal)
        
        self.dismiss(animated: true)
    }
    
}

struct ChoiceDateBottomSheetVC_Preview: PreviewProvider {
    static var previews: some View {
        ChoiceDateBottomSheetVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

//
//  SelectVisitDatePopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class SelectVisitDatePopUpVC: UIViewController {

    // MARK: Variables
    
    var popUpView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    var visitDateLabel: UILabel = UILabel().then {
        $0.text = "방문 일자"
        $0.font = title06
    }
    
    var calendarView: UIDatePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .inline
        $0.maximumDate = .now
        $0.timeZone = .current
        $0.tintColor = main03
        $0.addTarget(self, action: #selector(didFeedCalendarViewValueChanged), for: .valueChanged)
    }
    
    var selectButton: UIButton = UIButton().then {
        $0.setTitle("날짜 선택", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = gray04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .clear
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(popUpView)
        [
            visitDateLabel,
            calendarView,
            selectButton
        ].forEach { popUpView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        popUpView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(1.6)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didFeedCalendarViewValueChanged() {
        selectButton.isEnabled = true
        selectButton.backgroundColor = main03
    }
    
    @objc func didSelectButtonTapped() {
        self.dismiss(animated: true)
    }
}

struct SelectVisitDatePopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SelectVisitDatePopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

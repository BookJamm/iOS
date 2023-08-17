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
    
    /// 화면 여백을 클릭했을 때 팝업창 dismiss를 위한 view 선언
    var outsideView: UIView = UIView().then {
        $0.backgroundColor = .clear
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(outsideViewTapped)))
    }
    
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
    
    /// 뒷쪽 뷰 클릭하면 화면 dismiss되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .clear
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(outsideView)
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
        outsideView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(1.6)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-70)
        }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didFeedCalendarViewValueChanged() {
        selectButton.isEnabled = true
        selectButton.backgroundColor = main03
    }
    
    @objc func didSelectButtonTapped() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "feedVisitDateButtonTapped"), object: calendarView.date))
        self.dismiss(animated: true)
    }
    
    /// 팝업 뷰를 제외한 나머지 바깥 부분을 클릭했을 때 화면 dismiss
    @objc func outsideViewTapped() {
        print("바깥 뷰 클릭됨")
        self.dismiss(animated: true, completion: nil)
    }
}

struct SelectVisitDatePopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        SelectVisitDatePopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

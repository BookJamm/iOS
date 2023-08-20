//
//  BookStoreChoiceDateVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreChoiceDateVC: UIViewController {

    // MARK: Variables
    
    /// 디테일 페이지에서 넘어올 placeID 받을 변수 구현
    var placeID: Int = 2
    
    var placeInfoView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var placeInfoLabel: UILabel = UILabel().then {
        $0.text = "장소 정보"
        $0.font = title06
    }
    
    var placeView: UIView = UIView().then {
        $0.backgroundColor = gray02
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
    }
    
    var placeNameLabel: UILabel = UILabel().then {
        $0.text = "호매실 도서관"
        $0.font = title06
    }
    
    var placeTypeLabel: UILabel = UILabel().then {
        $0.text = "책 놀이터"
        $0.font = paragraph04
        $0.textColor = gray06
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var ratingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var numOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var visitDateView: UIView = UIView().then {
        $0.backgroundColor = .white
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
        $0.addTarget(self, action: #selector(didCalendarViewValueChanged), for: .valueChanged)
    }
    
    var writeReviewButton: UIButton = UIButton().then {
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = gray04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didReviewButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updatePlaceInfo()
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = gray01
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            placeInfoView,
            visitDateView,
        ].forEach { view.addSubview($0) }
        
        [
            placeInfoLabel,
            placeView
        ].forEach { placeInfoView.addSubview($0) }
        
        [
            placeNameLabel,
            placeTypeLabel,
            starImageView,
            ratingLabel,
            numOfReviewLabel
        ].forEach { placeView.addSubview($0) }
        
        [
            visitDateLabel,
            calendarView,
            writeReviewButton
        ].forEach { visitDateView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        placeInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        placeInfoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(placeInfoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(placeInfoLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(placeInfoView.snp.bottom).offset(-20)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        placeTypeLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(15)
            $0.leading.equalTo(placeNameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(placeTypeLabel.snp.bottom).offset(15)
            $0.leading.equalTo(placeTypeLabel)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        numOfReviewLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        visitDateView.snp.makeConstraints {
            $0.top.equalTo(placeInfoView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(visitDateLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(writeReviewButton.snp.top).offset(-10)
        }
        
        writeReviewButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
    }
    
    
    // MARK: Function
    
    @objc func didCalendarViewValueChanged() {
        writeReviewButton.backgroundColor = main03
        writeReviewButton.isEnabled = true
    }
    
    @objc func didReviewButtonTapped() {
        /// 넘겨줄 변수 할당
        var nextVC = BookStoreWriteReviewVC()
        nextVC.placeID = self.placeID
        let dateFormat: DateFormatter = DateFormatter().then { $0.dateFormat = "yyyy-MM-dd" }
        nextVC.date = dateFormat.string(from: calendarView.date)
        
        /// 화면 전환
        navigationController?.pushViewController(BookStoreWriteReviewVC(), animated: true)
    }
    
    /// placeID에 맞는 장소 정보 받아와서 view 업데이트
    func updatePlaceInfo() {
        APIManager.shared.getData(
            urlEndpointString: Constant.getPlaceId(placeId: placeID),
            responseDataType: APIModel<PlaceIdResponseModel>?.self,
            requestDataType: PlaceIdRequestModel.self,
            parameter: nil) { response in
                self.placeNameLabel.text = response?.result?.name!
                self.ratingLabel.text = String((response?.result?.rating!)!)
                self.numOfReviewLabel.text = "리뷰 \(String((response?.result?.reviewCount!)!))"
                
                if response?.result?.category! == 0 { self.placeTypeLabel.text = "독립서점" }
                else if response?.result?.category! == 1 { self.placeTypeLabel.text = "책 놀이터" }
                else if response?.result?.category! == 2 { self.placeTypeLabel.text = "도서관" }
            
            }
    }
    
}

struct BookStoreChoiceDateVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreChoiceDateVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}


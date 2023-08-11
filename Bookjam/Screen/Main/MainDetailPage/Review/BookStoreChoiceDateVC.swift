//
//  BookStoreChoiceDateVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

import SwiftUI
import UIKit

import FloatingPanel
import SnapKit
import Then


class BookStoreChoiceDateVC: UIViewController, FloatingPanelControllerDelegate {

    // MARK: Variables
    
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
    
    var selectVisitDateButton: UIButton = UIButton().then {
        $0.setTitle("    장소 방문 날짜 선택", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.contentHorizontalAlignment = .left
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray04?.cgColor
        $0.addTarget(self, action: #selector(didVisitDateButtonTapped), for: .touchUpInside)
    }
    
    var nextButton: UIButton = UIButton().then {
        $0.setTitle("업로드", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = gray04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
            selectVisitDateButton,
            nextButton
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
            $0.height.equalTo(130)
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
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        numOfReviewLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(10)
        }
        
        visitDateView.snp.makeConstraints {
            $0.top.equalTo(placeInfoView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        selectVisitDateButton.snp.makeConstraints {
            $0.top.equalTo(visitDateLabel.snp.bottom).offset(20)
            $0.leading.equalTo(visitDateLabel)
            $0.trailing.equalTo(placeView)
            $0.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Function
    
    //
    private func setupSheet() {
        // 밑으로 내려도 dismiss되지 않는 옵션 값
        isModalInPresentation = true

        if let sheet = sheetPresentationController {
            // 드래그를 멈추면 그 위치에 멈추는 지점: default는 large()
            sheet.detents = [.medium()]
            // 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            // sheet아래에 위치하는 ViewController를 흐려지지 않게 하는 경계값 (medium 이상부터 흐려지도록 설정)
            sheet.largestUndimmedDetentIdentifier = .none
            // sheet로 present된 viewController내부를 scroll하면 sheet가 움직이지 않고 내부 컨텐츠를 스크롤되도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            // grabber바 보이도록 설정
            sheet.prefersGrabberVisible = true
            // corner 값 설정
            sheet.preferredCornerRadius = 32.0
        }
    }
    
    @objc func didVisitDateButtonTapped() {
        present(ChoiceDateBottomSheetVC(), animated: true)
    }
    
}

struct BookStoreChoiceDateVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreChoiceDateVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}


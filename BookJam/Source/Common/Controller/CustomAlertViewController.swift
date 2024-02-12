//
//  AlertViewController.swift
//  BookJam
//
//  Created by 박민서 on 2/12/24.
//

import UIKit
import SnapKit
import Then
import RxSwift

/// Custom Alert의 Delegate입니다.
protocol CustomAlertDelegate {
    func action(alertType: AlertWindowType)   // confirm button event
    func exit()     // cancel button event
}

extension CustomAlertDelegate where Self: UIViewController {
    func showAlert(alertType: AlertWindowType) {
        
        let alertVC = CustomAlertViewController()
        alertVC.delegate = self // AlertController의 Delegate 위임
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.configureContent(alertType: alertType)
        self.present(alertVC, animated: true, completion: nil)
        
    }
}

class CustomAlertViewController: UIViewController {
    
    var delegate: CustomAlertDelegate?
    
    var disposeBag = DisposeBag()
    
    var alertType: AlertWindowType?
    
    /// 중앙 팝업 창
    private lazy var alertView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
//        $0.clipsToBounds = true
        $0.layer.shadowRadius = 10
        $0.layer.shadowColor = UIColor.gray08.cgColor
    }
    
    /// 컨텐츠 라벨
    private lazy var contentLabel: UILabel = UILabel().then {
        $0.numberOfLines = 2 // 최대 두 줄
        $0.textAlignment = .center
    }
    
    /// confirm 버튼
    private lazy var confirmButton: UIButton = UIButton().then {
        $0.backgroundColor = .gray02
        $0.layer.cornerRadius = 5
    }
    
    /// cancel 버튼
    private lazy var cancelButton: UIButton = UIButton().then {
        $0.backgroundColor = .main01
        $0.layer.cornerRadius = 5
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let alertType = self.alertType else {
            print("alertType not configured")
            cancelButtonTapped()
            return
        }
        
        setUpView()
        setUpLayout()
        if alertType.displayType == .fullSize {
            setUpConstraintWithButton()
        }
        if alertType.displayType == .textOnly {
            setUpConstraintWithoutButton()
        }
        setUpBinding()
    }
    

    // MARK: View
    private func setUpView() {
        self.view.backgroundColor = .gray08.withAlphaComponent(0.5)
    }
    
    
    // MARK: Layout
    private func setUpLayout() {
        [
            contentLabel,
            confirmButton,
            cancelButton
        ].forEach { alertView.addSubview($0) }
        
        [
            alertView
        ].forEach { view.addSubview($0) }
    }

    // MARK: Constraint
    private func setUpConstraintWithButton() {
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(330)
            $0.height.equalTo(185)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(64)
            $0.trailing.equalToSuperview().offset(-64)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(140)
            $0.height.equalTo(51)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(140)
            $0.height.equalTo(51)
        }

    }
    
    // MARK: Constraint
    private func setUpConstraintWithoutButton() {
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(330)
            $0.height.equalTo(70).priority(.low)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(46)
            $0.trailing.equalToSuperview().offset(-46)
        }
    }
    
    
    // MARK: Binding
    private func setUpBinding() {
        self.confirmButton.rx.tap
            .debounce(.milliseconds(250), scheduler: MainScheduler())
            .subscribe(onNext: { [weak self] _ in
                self?.confirmButtonTapped()
            })
            .disposed(by: disposeBag)
        
        self.cancelButton.rx.tap
            .debounce(.milliseconds(250), scheduler: MainScheduler())
            .subscribe(onNext: { [weak self] _ in
                self?.cancelButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    /// 확인 버튼 이벤트 처리
    private func confirmButtonTapped() {
        self.dismiss(animated: true) {
            guard let alertType = self.alertType else { return }
            self.delegate?.action(alertType: alertType)
        }
    }
    
    /// 취소 버튼 이벤트 처리
    private func cancelButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }
    }
    
    /// Alert 창의 내용 주입
    func configureContent(alertType: AlertWindowType) {
        self.alertType = alertType
        self.contentLabel.attributedText = alertType.attributedMainText
        self.confirmButton.setAttributedTitle(alertType.attributedConfirmButtonText, for: .normal)
        self.cancelButton.setAttributedTitle(alertType.attributedCancelButtonText, for: .normal)
    }
}

@available(iOS 17.0, *)
#Preview {
    CustomAlertViewController()
}

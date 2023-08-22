//
//  FeedPostCheckPopUpVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class FeedPostCheckPopUpVC: UIViewController {
    
    // MARK: Variables
    
    /// 화면 여백을 클릭했을 때 팝업창 dismiss를 위한 view 선언
    var outsideView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var checkView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    var checkLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "기록 작성을 완료하시겠습니까?"
    }
    
    var continueButton: UIButton = UIButton().then {
        $0.setTitle("아니요, 기록할래요.", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray03
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didContinueButtonTapped), for: .touchUpInside)
    }
    
    var doneButton: UIButton = UIButton().then {
        $0.setTitle("네, 완료할래요.", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = main01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didDoneButtonTapped), for: .touchUpInside)
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
    
    /// 뒷쪽 뷰 클릭하면 화면 dismiss되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(outsideView)
        view.addSubview(checkView)
        [
            checkLabel,
            continueButton,
            doneButton
        ].forEach { checkView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        outsideView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(160)
        }
        
        checkLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(checkView.snp.centerX).offset(-5)
            $0.height.equalTo(60)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalTo(checkView.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
    }
    
    
    // MARK: Function
    
    /// 기록 작성을 완료하지 않을 경우 팝업 화면만 dismiss
    @objc func didContinueButtonTapped() {
        print("완료 버튼 선택됨")
        
        self.dismiss(animated: true)
    }
    
    /// 기록 작성을 완료할 경우 PostPage에서 데이터를 Post하고 화면을 dismiss하기 위한 notification을 전송하고 팝업 화면을 dismiss
    @objc func didDoneButtonTapped() {
        print("완료 버튼 선택됨")
        
        NotificationCenter.default.post(name: NSNotification.Name("feedPostCheckButtonTapped"), object: nil)
        
        self.dismiss(animated: true)
    }
}

//struct FeedPostCheckPopUpVC_Preview: PreviewProvider {
//    static var previews: some View {
//        FeedPostCheckPopUpVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}

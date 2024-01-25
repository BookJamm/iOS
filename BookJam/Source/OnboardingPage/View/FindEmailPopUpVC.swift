//
//  FindEmailPopUpVC.swift
//  BookJam
//
//  Created by YOUJIM on 12/8/23.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class FindEmailPopUpVC: UIViewController {

    // MARK: Variables
    
    private let backgroundView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private let infoLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.text = "계정 관련 문의는\n1:1 문의로 진행해주세요."
        $0.numberOfLines = 2
        $0.setLineSpacing()
        $0.textAlignment = .center
    }
    
    private let infoButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.setTitle("문의 남기기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(didInfoButtonTapped), for: .touchUpInside)
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
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            backgroundView,
            infoLabel,
            infoButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(330)
            $0.height.equalTo(179)
            $0.centerX.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundView).offset(30)
        }
        
        infoButton.snp.makeConstraints {
            $0.height.equalTo(51)
            $0.leading.trailing.bottom.equalTo(backgroundView).inset(20)
        }
    }
    
    
    // MARK: Function
    
    // TODO: 일대일 문의 기능 정의 완료되면 따라서 기능 구현
    @objc private func didInfoButtonTapped() {
        
    }
    
}

struct FindEmailPopUpVC_Preview: PreviewProvider {
    static var previews: some View {
        FindEmailPopUpVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

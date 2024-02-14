//
//  MyPageHeaderView.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import UIKit
import SnapKit
import Then

final class MyPageHeaderView: UICollectionReusableView {
    
    // MARK: Variables
    static let id = "MyPageHeaderView"
    
    /// 타이틀 라벨
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph01
        $0.textColor = .black
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .white
    }
    
    private func setUpLayout() {
        [
            titleLabel
        ].forEach { self.addSubview($0) }
    }
    
    private func setUpConstraint() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20).priority(.low)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(title:String) {
        self.titleLabel.text = title
    }
    
}

@available(iOS 17.0, *)
#Preview {
    SearchPageCollecionHeaderView()
}

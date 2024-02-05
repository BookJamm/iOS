//
//  SearchPageCollecionHeaderView.swift
//  BookJam
//
//  Created by 박민서 on 2/6/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxRelay

final class SearchPageCollecionHeaderView: UICollectionReusableView {
    
    // MARK: Variables
    static let id = "SearchPageCollecionHeaderView"
    
    // Rx - DisposeBag
    let disposeBag = DisposeBag()
    
    // Rx - ViewModel
    var viewModel: MainPageCollectionHeaderViewModel? {
        didSet {
            setUpBinding()
        }
    }

    private lazy var titleLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
    }
    
    private lazy var seeMoreButton: UIButton = UIButton().then {
        $0.setAttributedTitle(.init(string: "더 보기", attributes: [.font: paragraph05!, .foregroundColor: UIColor.gray08]), for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpBinding()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .white
    }
    
    private func setUpBinding() {

    }
    
    private func setUpLayout() {
        [
            titleLabel,
            seeMoreButton
        ].forEach { self.addSubview($0) }
    }
    
    private func setUpConstraint() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
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

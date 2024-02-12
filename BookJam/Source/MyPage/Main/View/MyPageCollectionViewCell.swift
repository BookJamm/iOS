//
//  MyPageCollectionViewCell.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import UIKit
import SnapKit
import Then

class MyPageCollectionViewCell: UICollectionViewCell {
    
    static let id = "MyPageCollectionViewCell"
    
    lazy var listCellType: MyPageListCellType? = nil {
        didSet {
            self.applyConfigWithCellType(type: listCellType)
        }
    }
    
    /// 리스트 타이틀 라벨
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "default"
        $0.font = paragraph03
        $0.textColor = .black
    }
    
    lazy var settingSwitch: UISwitch = UISwitch().then {
        $0.onTintColor = .main01 // 추후 확인 필요
        $0.isHidden = true
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
            titleLabel,
            settingSwitch
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20).priority(.low)
        }
        
        settingSwitch.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configure(type: MyPageListCellType) {
        self.listCellType = type
    }
    
    /// 해당 Cell Type에 따라 타이틀 라벨의 속성을 조정합니다.
    private func applyConfigWithCellType(type: MyPageListCellType?) {
        
        guard let type = type else { return }
        
        self.titleLabel.text = type.title
            
        switch type {
        case .changeNotificationSetting:
            self.settingSwitch.isHidden = false
        case .logout:
            self.titleLabel.textColor = .red
        case .accountTermination:
            self.titleLabel.textColor = .gray05
        default:
            break
        }
    }
}

@available(iOS 17.0,*)
#Preview {
    MyPageCollectionViewCell()
}

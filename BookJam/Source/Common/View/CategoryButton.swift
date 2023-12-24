//
//  CategoryButton.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit
import SnapKit
import Then

class CategoryButton: UIButton {
    
    // MARK: variables
    
    /// 버튼의 카테고리
    var buttonCategory: Category?
    /// 비활성화 색
    var deactivatedColor: UIColor = .gray05
    
    /// 선택되었을때 true인 변수입니다
    var isOn: Bool = false {
        didSet {
            if isOn {
                self.configuration = selectedConfig()
                self.layer.borderColor = buttonCategory?.categoryColor.cgColor
            }
            else {
                self.configuration = defaultConfig()
                self.layer.borderColor = deactivatedColor.cgColor
            }
            self.setAttributedTitle(NSAttributedString(string: buttonCategory?.name ?? "", attributes: [.font : paragraph04!]), for: .normal)
        }
    }
    
    init(category: Category) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 110))
        
        // 프로퍼티 저장
        self.buttonCategory = category
        
        // MARK: - 기본설정 적용
        self.configuration = self.defaultConfig()
        self.layer.borderColor = deactivatedColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 13
        self.clipsToBounds = true

        self.setAttributedTitle(NSAttributedString(string: category.name, attributes: [.font : paragraph04!]), for: .normal)
        
        // MARK: - 선택했을 때 색 변경 TEST용
        self.addTarget(self, action: #selector(toggleColor), for: .touchUpInside)
    }
    
    // MARK: - 선택했을 때 색 변경 TEST용
    @objc func toggleColor() {
        self.isOn.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIButton 공통 Configuration
    private var commonConfig: UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.image = buttonCategory?.image.withTintColor(buttonCategory?.categoryColor ?? .blue, renderingMode: .alwaysTemplate) // 이미지 소스
        config.imagePlacement = .top // 이미지 위치
        config.imagePadding = 2.0 // 이미지 - 텍스트 간격
        config.contentInsets = .init(top: 15, leading: 30, bottom: 15, trailing: 30) // 전체 margin
        return config
    }
    
    /// 선택되지 않은 기본 설정
    private func defaultConfig() -> UIButton.Configuration {
        var config = commonConfig // 공통 설정
        config.baseForegroundColor = deactivatedColor
        config.background.backgroundColor = .clear
        return config
    }
    
    /// 선택되었을 때 설정
    private func selectedConfig() -> UIButton.Configuration {
        var config = commonConfig // 공통 설정
        config.baseForegroundColor = buttonCategory?.categoryColor
        config.background.backgroundColor = .clear
        return config
    }
}

@available(iOS 17.0, *)
#Preview {
    CategoryButton(category: .BookClub)
}

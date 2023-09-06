//
//  FilterButton.swift
//  Bookjam
//
//  Created by 박민서 on 2023/09/07.
//

import Foundation
import UIKit

/// 탭할 때마다 내부의 isOn 변수와 함께 컬러가 바뀝니다
class ColorToggleButton: UIButton {
    
    ///선택되었을때 true인 변수입니다
    var isOn: Bool = false {
        didSet {
            if isOn {
                self.configuration = selectedConfig()
                self.layer.borderWidth = 0
                self.setTitle(titleString, for: .normal)
            }
            else {
                self.configuration = defaultConfig()
                self.layer.borderWidth = 1.0
                self.setTitle(titleString, for: .normal)
            }
        }
    }
    
    var titleString: String?
    
    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        
        // MARK: - 기본설정 적용
        self.configuration = self.defaultConfig()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = gray05?.cgColor
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 18
        self.setTitle(title, for: .normal)
        self.titleString = title
        self.titleLabel?.font = captionText02
        
        // MARK: - 선택했을 때 색 변경
        self.addTarget(self, action: #selector(toggleColor), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleColor() {
        self.isOn.toggle()
    }
    
    /// 선택되지 않은 기본 설정
    private func defaultConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = gray05
        config.background.backgroundColor = .clear
        config.contentInsets = .init(top: 8, leading: 18, bottom: 8, trailing: 18)
        return config
    }
    
    /// 선택되었을 때 설정
    private func selectedConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.background.backgroundColor = main03
        config.contentInsets = .init(top: 8, leading: 18, bottom: 8, trailing: 18)
        return config
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ColorToggleButton_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = ColorToggleButton(title: "인기순")
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

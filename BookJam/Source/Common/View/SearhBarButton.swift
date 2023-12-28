//
//  SearhBarButton.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit


class SearhBarButton: UIButton {
    init(placeHolder: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 350, height: 44))
        
        // MARK: - 기본설정 적용
        var config = UIButton.Configuration.filled()
        config.image = .search
        config.imagePlacement = .leading // 이미지 위치
        config.imagePadding = 10.0 // 이미지 - 텍스트 간격
        config.contentInsets = .init(top: 10, leading: 16, bottom: 10, trailing: 16) // 전체 margin
        config.cornerStyle = .capsule
        config.baseForegroundColor = .gray06
        config.baseBackgroundColor = .gray01
        
        self.configuration = config
        self.setAttributedTitle(NSAttributedString(string: placeHolder, attributes: [.font : paragraph02!]), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0,*)
#Preview {
    SearhBarButton(placeHolder: "상호명 또는 주소 검색")
}

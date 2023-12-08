//
//  UILabel+.swift
//  BookJam
//
//  Created by YOUJIM on 12/8/23.
//

import Foundation
import UIKit


extension UILabel {
    // MARK: 라인 간 간격 주는 코드
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

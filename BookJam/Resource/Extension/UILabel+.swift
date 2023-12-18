//
//  UILabel+.swift
//  BookJam
//
//  Created by YOUJIM on 12/8/23.
//

import Foundation
import UIKit


extension UILabel {
    func setLineSpacing() {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func addLineSpacing(attributeString: NSAttributedString) {
        let attributedString = NSMutableAttributedString(attributedString: attributeString)
        let style = NSMutableParagraphStyle()
        
        style.lineHeightMultiple = 1.2
        attributedString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        
        attributedText = attributeString
    }
}

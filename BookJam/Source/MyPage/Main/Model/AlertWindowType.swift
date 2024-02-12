//
//  AlertWindowType.swift
//  BookJam
//
//  Created by 박민서 on 2/12/24.
//

import Foundation
import UIKit

/// 팝업 alert 창의 타입표시를 위한 enum입니다
enum AlertWindowType {
    /// 로그아웃
    case logout(userEmail: String)
    /// 회원탈퇴
    case accountTerminate(userEmail: String)
}

extension AlertWindowType {
    /// 폰트와 색 지정이 완료된 내용 텍스트
    var attributedMainText: NSAttributedString {
        switch self {
            
        case .logout(let userEmail):
            let text = "\(userEmail)\n계정에서 로그아웃이 됩니다."
            let attrString = NSMutableAttributedString(string: text)
            
            attrString.addAttribute(.foregroundColor, value: UIColor.alert, range: (text as NSString).range(of: "로그아웃"))
            
            attrString.addAttribute(.font, value: title05!, range: NSRange(location: 0, length: attrString.length))
            
            return attrString
            
        case .accountTerminate(let userEmail):
            let text = "\(userEmail)\n북잼에서 탈퇴 됩니다."
            let attrString = NSMutableAttributedString(string: text)
            
            attrString.addAttribute(.foregroundColor, value: UIColor.alert, range: (text as NSString).range(of: "탈퇴"))
            
            attrString.addAttribute(.font, value: title05!, range: NSRange(location: 0, length: attrString.length))
            
            return attrString
        }
    }
}

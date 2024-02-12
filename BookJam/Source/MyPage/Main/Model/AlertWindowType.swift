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
    /// 회원탈퇴 완료
    case accountTerminationCompleted
}

enum AlertWindowDisplaytype {
    /// 텍스트 라벨 + 버튼 2개
    case fullSize
    /// 텍스트라벨
    case textOnly
}


extension AlertWindowType {
    
    /// alert 창 UI 표시 타입
    var displayType: AlertWindowDisplaytype {
        switch self {
        case .logout, .accountTerminate:
            return .fullSize
        case .accountTerminationCompleted:
            return .textOnly
        }
    }
    
    /// 기본 폰트 설정의 내용 텍스트
    var mainText: String {
        switch self {
        case .logout(let userEmail):
            return "\(userEmail)\n계정에서 로그아웃이 됩니다."
        case .accountTerminate(let userEmail):
            return "\(userEmail)\n북잼에서 탈퇴 됩니다."
        case .accountTerminationCompleted:
            return "북잼에서 탈퇴가 완료되었습니다."
        }
    }
    
    /// 폰트와 색 지정이 완료된 내용 텍스트
    var attributedMainText: NSAttributedString {
        switch self {
            
        case .logout:
            let text = self.mainText
            let attrString = NSMutableAttributedString(string: text)
            
            attrString.addAttribute(.foregroundColor, value: UIColor.alert, range: (text as NSString).range(of: "로그아웃"))
            attrString.addAttribute(.font, value: title05!, range: NSRange(location: 0, length: attrString.length))
            
            return attrString
            
        case .accountTerminate, .accountTerminationCompleted:
            let text = self.mainText
            let attrString = NSMutableAttributedString(string: text)
            
            attrString.addAttribute(.foregroundColor, value: UIColor.alert, range: (text as NSString).range(of: "탈퇴"))
            attrString.addAttribute(.font, value: title05!, range: NSRange(location: 0, length: attrString.length))
            
            return attrString
        }
    }
    
    /// 기본 폰트 설정의 confirm 버튼 텍스트
    var confirmButtonText: String {
        switch self {
        case .logout:
            return "로그아웃"
        case .accountTerminate:
            return "회원탈퇴"
        case .accountTerminationCompleted:
            return "" // confirm 버튼 X
        }
    }
    
    /// 폰트와 색 지정이 완료된 confirm 버튼 텍스트
    var attributedConfirmButtonText: NSAttributedString {
        return NSAttributedString(
            string: self.confirmButtonText,
            attributes: [.font: paragraph02!, .foregroundColor: UIColor.black]
        )
    }
    
    /// 기본 폰트 설정의 cancel 버튼 텍스트
    var cancelButtonText: String {
        switch self {
        case .logout, .accountTerminate :
            return "아니오"
        case .accountTerminationCompleted:
            return "" // cancel 버튼 X
        }
    }
    
    /// 폰트와 색 지정이 완료된 cancel 버튼 텍스트
    var attributedCancelButtonText: NSAttributedString {
        return NSAttributedString(
            string: self.cancelButtonText,
            attributes: [.font: paragraph02!, .foregroundColor: UIColor.white]
        )
    }
}

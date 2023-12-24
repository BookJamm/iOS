//
//  Category.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit

/// 카테고리 목록 정보에 사용하는 enum입니다.
enum Category {
    /// 독립서점
    case BookStore
    /// 모임
    case BookClub
    /// 출판물
    case Pulication
    
    /// 해당 카테고리의 테마색입니다.
    var categoryColor: UIColor {
        switch self {
        case .BookStore:
            return .main01
        case .BookClub:
            return UIColor(hexCode: "80C80A")
        case .Pulication:
            return .active
        }
    }
    
    /// 해당 카테고리의 한글명입니다.
    var name: String {
        switch self {
        case .BookStore:
            return "독립서점"
        case .BookClub:
            return "모임"
        case .Pulication:
            return "출판물"
        }
    }
    
    /// 해당 카테고리의 테마 이미지입니다.
    var image: UIImage {
        switch self {
        case .BookStore:
            return .bookStore
        case .BookClub:
            return .activity
        case .Pulication:
            return .book
        }
    }
}

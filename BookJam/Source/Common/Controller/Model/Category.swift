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
    case Publication
    
    /// 해당 카테고리의 테마색입니다.
    var categoryColor: UIColor {
        switch self {
        case .BookStore:
            return .main01
        case .BookClub:
            return UIColor(hexCode: "80C80A")
        case .Publication:
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
        case .Publication:
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
        case .Publication:
            return .book
        }
    }
    
    /// 각 카테고리에 해당하는 필터 값을 반환합니다.
    var filters: [CombinedSearchFilter] {
        switch self {
        case .BookStore:
            return [.rating, .review, .distance]
        case .BookClub:
            return [.mostRecent, .mostPopular]
        case .Publication:
            return [.mostRecent, .mostPopular, .distance]
        }
    }
}

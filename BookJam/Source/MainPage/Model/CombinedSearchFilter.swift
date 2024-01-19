//
//  CombinedSearchFilter.swift
//  BookJam
//
//  Created by 박민서 on 12/30/23.
//

/// 데이터 검색에 사용하는 필터입니다.
enum CombinedSearchFilter {
    case rating
    case review
    case distance
    case mostRecent
    case mostPopular
    
    /// 해당 필터의 한글명을 반환합니다.
    var inKorean: String {
        switch self {
        case .rating:
            return "평점순"
        case .review:
            return "리뷰순"
        case .distance:
            return "거리순"
        case .mostPopular:
            return "인기순"
        case .mostRecent:
            return "최신순"
        }
    }
}

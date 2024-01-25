//
//  Filter.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

/// 검색 필터 모델입니다.
enum filters: String, CaseIterable {
    case rating = "rating"
    case review = "review"
    case distance = "distance"
    
    var inKorean: String {
        switch self {
        case .rating:
            return "평점순"
        case .review:
            return "리뷰순"
        case .distance:
            return "거리순"
        }
    }
}

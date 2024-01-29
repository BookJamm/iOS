//
//  BookStoreSearchFilter.swift
//  BookJam
//
//  Created by 박민서 on 12/30/23.
//

enum BookStoreSearchFilter: CaseIterable {
    case rating
    case review
    case distance
    
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

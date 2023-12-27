//
//  PublicationSearchFilter.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

enum PublicationSearchFilter: CaseIterable {
    case mostRecent
    case mostPopular
    case distance
    
    var inKorean: String {
        switch self {
        case .mostPopular:
            return "최신순"
        case .mostRecent:
            return "인기순"
        case .distance:
            return "거리순"
        }
    }
    
}

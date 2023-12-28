//
//  BookClubSearchFilter.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

enum BookClubSearchFilter: CaseIterable {
    case mostRecent
    case mostPopular
    
    var inKorean: String {
        switch self {
        case .mostPopular:
            return "최신순"
        case .mostRecent:
            return "인기순"
        }
    }
    
}

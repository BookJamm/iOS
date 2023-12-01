//
//  LocationCategory.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

enum LocationCategory: Int {
    case BookStore = 0
    case PlayGround = 1
    case Library = 2
    
    var inKorean: String {
        switch self {
        case .BookStore:
            return "독립 서점"
        case .PlayGround:
            return "책 놀이터"
        case .Library:
            return "도서관"
        }
    }
}

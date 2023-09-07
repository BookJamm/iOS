//
//  categoryModel.swift
//  Bookjam
//
//  Created by 박민서 on 2023/09/07.
//

enum LocationCategory: Int {
    case BookStore = 0
    case PlayGround = 1
    case Library = 2
    
    func getName_InKorean() -> String {
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

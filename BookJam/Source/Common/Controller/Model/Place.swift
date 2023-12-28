//
//  Place.swift
//  BookJam
//
//  Created by 박민서 on 12/1/23.
//

import Foundation

/// 서점 정보에 사용하는 모델입니다.
struct Place: Hashable {
    /// placeId : 서점 고유 식별자
    let placeId: Int?
    /// name : 서점 이름
    let name: String?
    /// rating : 별점 float
    let rating: Float?
    /// reviewCount : 리뷰 갯수
    let reviewCount: Int?
    /// category: 0 - 독립서점, 1 - 책 놀이터, 2 - 도서관
    let category: Int?
    /// open: true - 영업중 false - 영업X
    let open: Bool?
    /// images: 서점 이미지 Array
    let images: [Image]?
    /// address: 주소 model
    let address: Address?
    /// coords: 좌표 model
    let coords: Coordinate?
}

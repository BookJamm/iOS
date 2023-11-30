//
//  Place.swift
//  BookJam
//
//  Created by 박민서 on 12/1/23.
//

import Foundation

/// 서점 정보에 사용하는 모델입니다.
/// placeId : 서점 고유 식별자
/// name : 서점 이름
/// rating : 별점 float
/// review : 리뷰 갯수
/// category: 0 - 독립서점, 1 - 책 놀이터, 2 - 도서관
/// open: true - 영업중 false - 영업X
/// images: 서점 이미지 Array
/// address: 주소 model
/// coords: 좌표 model
struct Place: Hashable {
    let placeId: Int?
    let name: String?
    let rating: Float?
    let reviewCount: Int?
    let category: Int?
    let open: Bool?
    let images: [Image]?
    let address: Address?
    let coords: Coordinate?
}

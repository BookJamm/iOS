//
//  getPlaces.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/14.
//

import Foundation

/// getPlaces에서 사용
struct PlacesRequestModel: Encodable {
    let category: Int
    let sortBy: String?
    let lat: Float?
    let lon: Float?
    let last: Int?
}

/// getPlaces에서 사용
/// 서점 목록을 불러올 때 사용하는 API RESPONSE Model입니다.
/// placeId : 서점 고유 식별자
/// name : 서점 이름
/// rating : 별점 float
/// review : 리뷰 갯수
/// category: 0 - 독립서점, 1 - 책 놀이터, 2 - 도서관
/// open: true - 영업중 false - 영업X
/// images: 서점 이미지 Array
/// address: 주소 model
/// coords: 좌표 model
struct PlacesResponseModel: Decodable {
    let placeId: Int?
    let name: String?
    let rating: Float?
    let reviewCount: Int?
    let category: Int?
    let open: Bool?
    let images: [ImageDTO]?
    let address: AddressDTO?
    let coords: CoordinateDTO?
}

extension PlacesResponseModel {
    func toDomain() -> Place {
        return .init(placeId: placeId,
                     name: name,
                     rating: rating,
                     reviewCount: reviewCount,
                     category: category,
                     open: open,
                     images: images.map { $0.map { $0.toDomain() } },
                     address: address.map{ $0.toDomain() },
                     coords: coords.map { $0.toDomain() })
    }
}



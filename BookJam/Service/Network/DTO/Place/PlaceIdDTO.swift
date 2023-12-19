//
//  PlaceId.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/17.
//

import Foundation

struct PlaceIdRequestModel: Encodable {
    let placeId: Int
}

/// getPlaceId에 사용
struct PlaceIdResponseModel: Decodable {
    let placeId: Int?
    let name: String?
    let category: Int?
    let rating: Float?
    let reviewCount: Int?
    let website: String?
    let address: AddressDTO?
    let images: [ImageDTO]?
    let open : Bool?
    let bookmarked: Bool?
}

//
//  PlaceId.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/17.
//

import Foundation

struct PlaceIdRequestModel: Codable {
    let placeId: Int
}

struct PlaceIdResponseModel: Codable {
    let placeId: Int?
    let name: String?
    let category: Int?
    let rating: Float?
    let reviewCount: Int?
    let website: String?
    let address: Address?
    let images: [Image]?
    let open : Bool?
    let bookmarked: Bool?
}


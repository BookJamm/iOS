//
//  KeywordSearch.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/15.
//

import Foundation

/// getPlacesSearch에 사용
struct KeywordSearchRequestModel: Encodable {
    let keyword: String?
    let sortBy: String?
    let lat: Float?
    let lon: Float?
}

/// getPlacesSearch에 사용
struct KeywordSearchResponseModel: Decodable {
    let placeId: Int?
    let name: String
    let category: Int
    let address: AddressDTO?
}


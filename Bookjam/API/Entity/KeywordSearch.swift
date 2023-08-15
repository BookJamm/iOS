//
//  KeywordSearch.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/15.
//

import Foundation

struct KeywordSearchRequestModel: Codable {
    let keyword: String?
    let sortBy: String?
    let lat: Float?
    let lon: Float?
}

struct KeywordSearchResponseModel: Codable {
    let placeId: Int?
    let name: String
    let category: Int
    let address: Address?
}

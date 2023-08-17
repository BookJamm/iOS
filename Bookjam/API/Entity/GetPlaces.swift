//
//  getPlaces.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/14.
//

import Foundation

struct getPlaceRequestModel: Codable {
    let category: Int
    let sortBy: String?
    let lat: Float?
    let lon: Float?
    let last: Int?
    
    init(category: Int, sortBy: String? = nil, lat: Float? = nil, lon: Float? = nil, last: Int? = nil) {
            self.category = category
            self.sortBy = sortBy
            self.lat = lat
            self.lon = lon
            self.last = last
        }
    
}

struct GetPlaceResponseModel: Codable {
    let placeId: Int?
    let name: String?
    let rating: Float?
    let reviewCount: Int?
    let category: Int?
    let open: Bool?
    let images: [Image]?
    let address: Address?
}

struct Image: Codable {
    let id: Int?
    let url: String?
}

struct Address: Codable {
    let road: String
    let jibun: String?
}

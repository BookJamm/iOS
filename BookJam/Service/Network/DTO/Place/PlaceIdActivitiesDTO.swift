//
//  PlaceIdActivity.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/19.
//

import Foundation

/// getPlaceActivitiesURL에 사용
struct PlaceIdActivitiesResponseModel: Decodable {
    let error: Bool?
    let result: [ActivitiesDTO]
}

struct ActivitiesDTO: Decodable {
    let activityId: Int?
    let createdAt: String?
    let updatedAt: String?
    let placeId: Int?
    let title: String
    let info: String
    let capacity: Int?
    let headcount: Int?
    let totalRating: Float?
    let reviewCount: Int?
    let imageUrl: String?
//    let like_count: Int?
}

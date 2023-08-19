//
//  PlaceIdActivity.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/19.
//

import Foundation

struct PlaceIdActivitiesResponseModel: Codable {
    let activityId: Int?
    let createdAt: String?
    let updatedAt: String?
    let placeId: Int?
    let title: String
    let info: String
    let capacity: Int?
    let headcount: Int?
    let totalRating: Int?
    let reviewCount: Int?
    let imageUrl: String?
    
}

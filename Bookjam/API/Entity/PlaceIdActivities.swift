//
//  PlaceIdActivity.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/19.
//

import Foundation

struct PlaceIdActivitiesResponseModel: Codable {
    let error: Bool?
    
    let result: [Activities]
}

struct Activities: Codable{
    let activity_id: Int?
    let created_at: String?
    let updated_at: String?
    let place_id: Int?
    let title: String
    let info: String
    let capacity: Int?
    let headcount: Int?
    let total_rating: Int?
    let review_count: Int?
    let image_url: String?
    let like_count: Int?
}

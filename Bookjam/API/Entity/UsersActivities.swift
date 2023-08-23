//
//  UsersActivities.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

struct UsersActivitiesRequestModel: Codable {
    
}

struct UsersActivitiesResponseModel: Codable {
    let userActivities: [UserActivities]
}

struct UserActivities: Codable {
    let activity_id: Int?
    let title: String?
    let total_rating: Float?
    let review_count: Int?
    let image_url: String?
}

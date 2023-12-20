//
//  UsersActivities.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

///// getUsersActivities에서 사용
//struct UsersActivitiesRequestModel: Encodable {
//
//}

/// getUsersActivities에서 사용
struct UsersActivitiesResponseModel: Decodable {
    let userActivities: [UserActivitiesDTO]
}

struct UserActivitiesDTO: Decodable {
    let activity_id: Int?
    let title: String?
    let total_rating: Float?
    let review_count: Int?
    let image_url: String?
}

//
//  UsersReviews.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

//struct UsersReviewsRequestModel: Codable {
//    
//}

struct UsersReviewsResponseModel: Decodable {
    let userReviews: [UserReviewsDTO]
}

struct UserReviewsDTO: Decodable {
    let review_id: Int?
    let visited_at: String?
    let name: String?
    let category: Int?
    let image_url: String?
}

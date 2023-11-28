//
//  PlaceIdReviews.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/20.
//

import Foundation

struct PlaceIdReviewsResponseModel: Codable, Hashable {
    let reviewId: Int?
    let visitedAt: String?
    let contents: String?
    let rating: Float?
    let images: [Image]?
    let author: Author
}

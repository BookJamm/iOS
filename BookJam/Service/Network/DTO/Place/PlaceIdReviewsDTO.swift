//
//  PlaceIdReviews.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/20.
//

import Foundation

/// getPlaceReviewsURL에 사용
struct PlaceIdReviewsResponseModel: Decodable {
    let reviewId: Int?
    let visitedAt: String?
    let contents: String?
    let rating: Float?
    let images: [ImageDTO]?
    let author: AuthorDTO
}

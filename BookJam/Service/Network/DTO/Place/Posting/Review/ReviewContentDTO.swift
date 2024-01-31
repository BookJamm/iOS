//
//  ReviewContent.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/19.
//

import Foundation

/// postPlacesReviews에 사용
struct ReviewContentRequestModel: Encodable {
    let visitedAt: String?
    let contents: String?
    let rating: Float?
}

/// postPlacesReviews에 사용
struct ReviewContentResponseModel: Decodable {
    let reviewId: Int?
}

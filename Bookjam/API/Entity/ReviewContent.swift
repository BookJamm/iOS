//
//  ReviewContent.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/19.
//

import Foundation

struct ReviewContentRequestModel: Codable {
    let visitedAt: String?
    let contents: String?
    let rating: Float?
}

struct ReviewContentResponseModel: Codable {
    let reviewId: Int?
}

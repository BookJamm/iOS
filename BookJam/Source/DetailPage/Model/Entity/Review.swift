////
////  Review.swift
////  BookJam
////
////  Created by 장준모 on 11/13/23.
////
//
//import Foundation
//
//struct PlaceIdReviewsResponseModel: Decodable, Hashable {
//    let reviewId: Int
//    let visitedAt: String
//    let contents: String
//    let rating: Float
//    let images: [Image]
//    let author: Author
//    
//    private enum CodingKeys: String, CodingKey {
//        case reviewId
//        case visitedAt
//        case contents
//        case rating
//        case images
//        case author
//    }
//    
//    init(reviewId: Int, visitedAt: String, contents: String, rating: Float, images: [Image], author: Author) {
//        self.reviewId = reviewId
//        self.visitedAt = visitedAt
//        self.contents = contents
//        self.rating = rating
//        self.images = images
//        self.author = author
//    }
//}

//
//  Reviews.swift
//  BookJam
//
//  Created by 장준모 on 12/6/23.
//

import Foundation
struct Review: Hashable {
    
    let reviewId: Int?
    let visitedAt: String?
    let contents: String?
    let rating: Float?
    let images: [Image]?
    let author: Author
        
}

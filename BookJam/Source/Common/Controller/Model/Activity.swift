//
//  Activity.swift
//  BookJam
//
//  Created by 장준모 on 12/6/23.
//

import Foundation

struct Activity: Hashable {
    
    let activityId: Int?
    let createdAt: String?
    let updatedAt: String?
    let placeId: Int?
    let title: String
    let info: String
    let capacity: Int?
    let headcount: Int?
    let totalRating: Float?
    let reviewCount: Int?
    let imageUrl: String?
    //    let like_count: Int?
    
}

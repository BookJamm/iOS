//
//  News.swift
//  BookJam
//
//  Created by 장준모 on 11/13/23.
//

import Foundation

struct PlaceIdNewsResponseModel: Codable, Hashable {
    let newsId: Int?
    let createdAt: String?
    let updatedAt: String?
    let title: String?
    let contents: String?
    let placeId: Int?

}

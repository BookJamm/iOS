//
//  PlaceIdNews.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/18.
//

import Foundation

struct PlaceIdNewsResponseModel: Codable {
    let newsId: Int?
    let createdAt: String?
    let updatedAt: String?
    let title: String?
    let contents: String?
    let placeId: Int?

}

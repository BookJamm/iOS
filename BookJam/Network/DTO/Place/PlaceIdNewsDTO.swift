//
//  PlaceIdNews.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/18.
//

import Foundation

/// getPlaceNewsURL에 사용
struct PlaceIdNewsResponseModel: Decodable {
    let newsId: Int?
    let createdAt: String?
    let updatedAt: String?
    let title: String?
    let contents: String?
    let placeId: Int?

}

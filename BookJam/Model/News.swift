//
//  News.swift
//  BookJam
//
//  Created by 장준모 on 12/6/23.
//

import Foundation

struct News: Hashable {
    let newsId: Int?
    let createdAt: String?
    let updatedAt: String?
    let title: String?
    let contents: String?
    let placeId: Int?
}

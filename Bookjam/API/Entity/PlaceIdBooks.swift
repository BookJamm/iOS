//
//  PlaceIdBooks.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/19.
//

import Foundation

struct PlaceIdBooksResponseModel: Codable {
    let title: String?
    let author: String?
    let cover: String?  //이미지
    let description: String?
    let isbn: String?
}

//
//  Books.swift
//  BookJam
//
//  Created by 장준모 on 11/13/23.
//

import Foundation

struct PlaceIdBooksResponseModel: Codable, Hashable {
    let title: String?
    let author: String?
    let cover: String?  //이미지
    let description: String?
    let isbn: String?
    let publisher: String?
}

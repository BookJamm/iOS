//
//  BooksList.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

struct BooksListResponseModel: Codable {
    var title: String?
    var author: String?
    var cover: String?
    var isbn: String?
}

struct BooksListRequestModel: Codable {
    
}

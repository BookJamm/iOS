//
//  Book.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

struct Book {
    var title: String?
    var author: String?
    var cover: String?
    var isbn: String?

    // 일단 이거 빼고, DTO에서 toDomain()을 추가합시다.
//    init(responseModel: BooksListResponseModel) {
//        self.title = responseModel.title
//        self.author = responseModel.author
//        self.cover = responseModel.cover
//        self.isbn = responseModel.isbn
//    }
}

//
//  BooksList.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

//struct BooksListRequestModel: Encodable // 사용되지 않습니다.

/// getBooksList에서 사용
struct BooksListResponseModel: Decodable {
    var title: String?
    var author: String?
    var cover: String?
    var isbn: String?
}

extension BooksListResponseModel {
    func toDomain() -> Book {
        return .init(title: title,
                     author: author,
                     cover: cover,
                     isbn: isbn)
        // if movies is struct - movies: movies.map { $0.toDomain() }
    }
}

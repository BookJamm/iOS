//
//  Record.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import Foundation

/// postRecord에 사용
struct RecordRequestModel: Encodable {
    // let place: Int?
    let isbn: Int?
    let date: String?
    let emotions: Int?
    let activity: Int?
    let contents: String?
    let isNotPublic: Int?
    let commentNotAllowed: Int?
}

/// postRecord에 사용
struct RecordResponseModel: Decodable {
    let recorded: Bool?
    let recordId: Int?
}



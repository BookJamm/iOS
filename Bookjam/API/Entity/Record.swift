//
//  Record.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/16.
//

import Foundation

struct RecordResponseModel: Codable {
    let recorded: Bool?
    let recordId: Int?
}

struct RecordRequestModel: Codable {
    let place: Int?
    let isbn: Int?
    let date: String?
    let emotions: Int?
    let activity: Int?
    let contents: String?
    let isNotPublic: Int?
    let commentNotAllowed: Int?
}

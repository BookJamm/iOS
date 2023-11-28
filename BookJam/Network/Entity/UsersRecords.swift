//
//  UsersRecords.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

struct UsersRecordsResponseModel: Codable {
    let record_id: Int?
    let author: Int?
    let created_at: String?
    let status: Int?
    let date: String?
    let place_id: Int?
    let name: String?
    let category: Int?
    let isbn: String?
    let activities: Int?
    let emotions: Int?
    let contents: String?
    let comment_not_allowed: Int?
    let comment_count: Int?
    let like_count: Int?
    let images_url: String?
}

struct UsersRecordsRequestModel: Codable {
    
}

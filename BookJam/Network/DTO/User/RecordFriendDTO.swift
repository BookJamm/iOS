//
//  RecordFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/22.
//

import Foundation

/// getRecordsFriends에 사용
struct RecordsFriendResponseModel: Decodable {
    let record_id, user_id: Int
    let username: String
    let profile_image: String
    let created_at: String
    let status: Int
    let date: String
    let place_id: Int?
    let name: String?
    let category: Int
    let book: String?
    let activities, emotions: Int
    let contents: String
    let comment_not_allowed, comment_count, like_count: Int
    let images_url: [String]?
    let liked: Int
}

//struct RecordsFriendRequestModel: Codable {
//
//}

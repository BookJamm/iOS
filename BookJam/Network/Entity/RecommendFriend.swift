//
//  RecommendFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/17.
//

import Foundation

struct RecommendFriendRequestModel: Codable {
    
}

struct RecommendFriendResponseModel: Codable {
    let userId: Int?
    let name, email, username, profileImage: String?
}

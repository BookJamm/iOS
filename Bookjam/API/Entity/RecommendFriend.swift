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
    let recommendFriends: [RecommendFriend]
}

struct RecommendFriend: Codable {
    let user_id: Int?
    let name, email, username, profile_image: String?
}

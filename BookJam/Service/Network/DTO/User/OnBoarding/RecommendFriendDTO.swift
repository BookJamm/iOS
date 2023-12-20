//
//  RecommendFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/17.
//

import Foundation

/// getAuthFriends에 사용
struct RecommendFriendResponseModel: Decodable {
    let userId: Int?
    let name, email, username, profileImage: String?
}

//struct RecommendFriendRequestModel: Codable {
//    
//}



//
//  SearchFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation

struct SearchFriendRequestModel: Codable {
    let email: String?
}

struct SearchFriendResponseModel: Codable {
    let result: String?
}

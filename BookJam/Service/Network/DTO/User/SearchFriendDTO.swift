//
//  SearchFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation

/// getSearchUser에서 사용
struct SearchFriendRequestModel: Encodable {
    let email: String?
}

/// getSearchUser에서 사용
struct SearchFriendResponseModel: Decodable {
    // 미완?
}

//
//  AddFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/23.
//

import Foundation

struct friendInfo: Codable {
    var nickname: String
    var email: String
    var photoURL: String
    var isFriend: Bool
}

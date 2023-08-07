//
//  AddFriend.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/23.
//

// MARK: - 온보딩 05에서 표시될 친구 정보를 담은 구조체 선언한 파일

import Foundation

struct Friend: Codable {
    var nickname: String
    var email: String
    var photoURL: String
    var isFriend: Bool
}

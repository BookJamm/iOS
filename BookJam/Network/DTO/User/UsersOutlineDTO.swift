//
//  UsersOutline.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

//struct UsersOutlineRequestModel: Codable

/// getUsersOutline에서 사용
struct UsersOutlineResponseModel: Decodable {
    let userOutline: UserOutlineDTO?
}

struct UserOutlineDTO: Decodable {
    let userId: Int?
    let profile: String?
    let username: String?
    let review: Int?
    let reserve: Int?
    let record: Int?
}



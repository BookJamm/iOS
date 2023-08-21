//
//  UsersOutline.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

struct UsersOutlineResponseModel: Codable {
    let userOutline: UserOutline?
}

struct UserOutline: Codable {
    let userId: Int?
    let profile: String?
    let username: String?
    let review: Int?
    let reserve: Int?
    let record: Int?
}

struct UsersOutlineRequestModel: Codable {
    
}

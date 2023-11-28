//
//  singUp.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/14.
//

import Foundation

struct SignUpRequestModel: Codable {
    let kakao: Int?
    let email: String?
    let password: String?
    let username: String?
}

struct SignUPResponseModel: Codable {
    let result: String?
}

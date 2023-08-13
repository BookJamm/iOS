//
//  users.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/21.
//

// MARK: - 유저 정보 저장을 위한 싱글톤 클래스 선언

import Foundation

/// 싱글톤 클래스 선언
class UserInfo {
    static let shared = UserInfo()
    
    var user = User()
    
    private init() {}
}

struct User {

    var ID: Int?
    var name: String?
    var email: String?
    var password: String?
    // var mobile: String?
    // var profileImage: String?
    // var username: String?
    // var createdAt: String?
    // var updatedAt: String?
    // var disabledAt: String?
    var kakaoToken: String?    //카카오 토큰인데 임시로 타입을 String으로 하였습니다.

//    enum CodingKeys: String, CodingKey {
//        case ID = "user_id"
//        case name = "name"
//        case email = "email"
//        case password = "password"
//        case mobile = "mobile"
//        case profileImage = "profile_image"
//        case username = "username"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case disabledAt = "disabled_at"
//        case kakaoToken = "kakao_token"
//    }
}

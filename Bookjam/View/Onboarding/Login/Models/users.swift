//
//  users.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/21.
//

import Foundation
import Alamofire

struct userModel: Codable {
   
    var user_id: Int
    var name: String
    var email: String
    var password: String
    var mobile: String
    var profile_image: String?
    var username: String
    var created_at: String
    var updated_at: String?
    var disabled_at: String?
    var kakao_token: String?    //카카오 토큰인데 임시로 타입을 String으로 하였습니다.
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case name = "name"
        case email = "email"
        case password = "password"
        case mobile = "mobile"
        case profile_image = "profile_image"
        case username = "username"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case disabled_at = "disabled_at"
        case kakao_token = "kakao_token"
    }
    
}

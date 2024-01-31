//
//  Login.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/13.
//

import Foundation


/// postAuthLogin에서 사용
struct UserLoginRequestModel: Encodable {
    var email: String
    var password: String
}

/// postAuthLogin에서 사용
struct UserLoginResponseModel: Decodable {

}


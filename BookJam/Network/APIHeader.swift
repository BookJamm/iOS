//
//  APIHeader.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

import Foundation
import Alamofire

enum APIHeader {
    // 얘네 테스트용이니 다 날려야 함
    static let jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMzLCJpYXQiOjE2OTIwMDExNDQsImV4cCI6MTc5MjAwNDc0NCwiaXNzIjoiYm9va2phbSJ9.BGN1CGC4Zu8xRVuH_zA-aTK1GYMWvNitR2mAfgG1zWU"

    static let kakaoAppID = "e71c9521872b70f64acf3a7139889342"
    
    case header
    case sendImageHeader
    
    var getValue: HTTPHeaders {
        switch self {
        case .header :
            return [    //임시 슈퍼 jwt 토큰
                "Authorization": "Bearer \(APIHeader.jwtToken)"
            ]
        case .sendImageHeader :
            return [
                "Authorization": "Bearer \(APIHeader.jwtToken)",
                "Content-Type" : "multipart/form-data"
            ]
        }
    }

    // 추후 Token 로직 구현되었을 때 예시 with KeyChain
//    case .logout:
//        return ["Authorization": KeyChain.shared.read(account: .accessToken),
//                "Refresh-Token": KeyChain.shared.read(account: .refreshToken),
//                "Content-Type": "application/json"]
//    default:
//        return ["Authorization": KeyChain.shared.read(account: .accessToken),
//                "Content-Type": "application/json"]
}

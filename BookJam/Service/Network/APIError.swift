//
//  NetworkError.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

import Foundation

enum APIError: Error {
    /// 옳지 않은 URL
    case invalidURL
    /// response가 옳지 않을 때
    case invalidResponse
    /// status code : 400 ~ 499
    case badRequest(String?)
    /// status code :  500
    case serverError(String?)
    /// Json으로 parsing 에러
    case parseError(String?)
    /// 알 수 없는 에러.
    case unknown
}


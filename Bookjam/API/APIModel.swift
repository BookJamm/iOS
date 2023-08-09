//
//  APIModel.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

// MARK: 서버에서 오는 응답값 저장할 구조체 Generic으로 구현

import Foundation

struct APIModel<T: Codable>: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let result: T?
}

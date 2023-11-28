//
//  BaseResponse.swift
//  BookJam
//
//  Created by 박민서 on 11/27/23.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool?
    let code: Int?
    let message: String?
    let result: T?
}

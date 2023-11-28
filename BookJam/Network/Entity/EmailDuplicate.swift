//
//  EmailDuplicate.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation

struct DuplicateResponseModel: Codable {
    let isEmailTaken: Bool?
}

struct DuplictateRequestModel: Codable {
    let email: String
}

//
//  EmailDuplicate.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation

/// postAuthEmailCheck에서 사용
struct DuplictateRequestModel: Encodable {
    let email: String
}

/// postAuthEmailCheck에서 사용
struct DuplicateResponseModel: Decodable {
    let isEmailTaken: Bool?
}

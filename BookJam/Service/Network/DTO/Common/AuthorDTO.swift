//
//  AuthorDTO.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

struct AuthorDTO: Decodable {
    let userId: Int?
    let username: String?
    let profileImage: String?
}

extension AuthorDTO {
    func toDomain() -> Author {
        return .init(userId: userId,
                     username: username,
                     profileImage: profileImage)
    }
}

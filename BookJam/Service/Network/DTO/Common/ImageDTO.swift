//
//  ImageDTO.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

/// 이미지에 사용하는 모델입니다
/// id : 이미지 id
/// url : 이미지 URL
struct ImageDTO: Decodable {
    let id: Int?
    let url: String?
}

extension ImageDTO {
    func toDomain() -> Image {
        return .init(id: id,
                     url: url)
    }
}

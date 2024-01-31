//
//  AddressDTO.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

/// 주소에 사용하는 모델입니다
/// road : 도로명
/// jibun : 지번
struct AddressDTO: Decodable {
    let road: String
    let jibun: String?
}

extension AddressDTO {
    func toDomain() -> Address {
        return .init(road: road,
                     jibun: jibun)
    }
}

//
//  CoordinateDTO.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

/// 좌표에 사용하는 모델입니다
/// lat : 위도
/// lon: 경도
struct CoordinateDTO: Decodable {
    let lat: String?
    let lon: String?
}

extension CoordinateDTO {
    func toDomain() -> Coordinate {
        return .init(lat: lat, 
                     lon: lon)
    }
}

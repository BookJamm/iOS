//
//  Coordinate.swift
//  BookJam
//
//  Created by 박민서 on 12/1/23.
//

import Foundation

/// 좌표에 사용하는 모델입니다
/// lat : 위도
/// lon: 경도
struct Coordinate: Hashable {
    let lat: String?
    let lon: String?
}

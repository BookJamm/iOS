//
//  Image.swift
//  BookJam
//
//  Created by 박민서 on 12/1/23.
//

import Foundation

/// 이미지에 사용하는 모델입니다
/// id : 이미지 id
/// url : 이미지 URL
struct Image: Hashable {
    let id: Int?
    let url: String?
}

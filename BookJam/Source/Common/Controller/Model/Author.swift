//
//  Author.swift
//  BookJam
//
//  Created by 박민서 on 12/1/23.
//

import Foundation

/// 작성자 정보에 사용하는 모델입니다
/// userId : 작성자 userId
/// username : 작성자 이름
/// profileImage : 작성자 프로필 이미지 URL

struct Author: Hashable {
    let userId: Int?
    let username: String?
    let profileImage: String?
}

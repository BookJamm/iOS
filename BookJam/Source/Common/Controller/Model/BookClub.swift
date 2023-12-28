//
//  BookClub.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import Foundation

/// 모임 정보에 사용하는 모델입니다.
struct BookClub: Hashable {
    /// bookClubID : 모임 ID
    var bookClubID: Int?
    /// name : 모임 이름
    var name: String?
    /// date : 모임 날짜
    var date: Date?
    /// cover : 커버사진 URL:
    var cover: String?
    /// place: 모임 서점 위치
    var place: String?
    /// type: 모임 유형
    var type: String?
}

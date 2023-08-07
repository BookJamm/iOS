//
//  ReviewInfo.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/03.
//

// MARK: - 디테일 페이지에서 상점 리뷰 정보 받아올 때 사용할 구조체 선언한 파일

import Foundation

struct Review {
    var userName: String
    var visitDate: String
    var comment: String
    var photos: [String]
}

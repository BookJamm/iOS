//
//  PlaceId.swift
//  BookJam
//
//  Created by 장준모 on 1/17/24.
//

import Foundation

//서점 디테일에 해당하는 모델입니다

struct DetailHomeTabModel: Hashable {
    
    var homeList: [PlaceId1]
    var bookList: [Book]
    var activityList: [Activity]
    var reviewList: [Review]
    var newsList: [News]
}

struct PlaceId1: Hashable {
    
    /// placeId : 서점 고유 식별자
    let placeId: Int?
    /// name : 서점 이름
    let name: String?
    /// category: 0 - 독립서점, 1 - 책 놀이터, 2 - 도서관
    let category: Int?
    /// rating : 별점 float
    let rating: Float?
    /// reviewCount : 리뷰 갯수
    let reviewCount: Int?
    /// website: 웹사이트 주소
    let website: String?
    /// address: 주소 model
    let address: Address?
    /// images: 서점 이미지 Array
    let images: [Image]?
    /// open: true - 영업중 false - 영업X
    let open: Bool?
    /// bookmaked: 북마크 여부
    let bookmaked: Bool?
    
}

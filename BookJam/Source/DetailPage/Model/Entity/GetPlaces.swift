////
////  GetPlaces.swift
////  BookJam
////
////  Created by 장준모 on 11/13/23.
////
//
//import Foundation
//
//struct getPlaceRequestModel: Codable, Hashable {
//    let category: Int
//    let sortBy: String?
//    let lat: Float?
//    let lon: Float?
//    let last: Int?
//    
//    init(category: Int, sortBy: String? = nil, lat: Float? = nil, lon: Float? = nil, last: Int? = nil) {
//            self.category = category
//            self.sortBy = sortBy
//            self.lat = lat
//            self.lon = lon
//            self.last = last
//        }
//    
//}
//
///// 서점 목록을 불러올 때 사용하는 API RESPONSE Model입니다.
///// placeId : 서점 고유 식별자
///// name : 서점 이름
///// rating : 별점 float
///// review : 리뷰 갯수
///// category: 0 - 독립서점, 1 - 책 놀이터, 2 - 도서관
///// open: true - 영업중 false - 영업X
///// images: 서점 이미지 Array
///// address: 주소 model
///// coords: 좌표 model
//struct GetPlaceResponseModel: Codable, Hashable {
//    let placeId: Int?
//    let name: String?
//    let rating: Float?
//    let reviewCount: Int?
//    let category: Int?
//    let open: Bool?
//    let images: [Image]?
//    let address: Address?
//    let coords: Coordinate?
//}
//
///// 이미지에 사용하는 모델입니다
///// id : 이미지 id
///// url : 이미지 URL
//struct Image: Codable, Hashable {
//    let id: Int?
//    let url: String?
//}
//
///// 주소에 사용하는 모델입니다
///// road : 도로명
///// jibun : 지번
//struct Address: Codable, Hashable {
//    let road: String
//    let jibun: String?
//}
//
///// 좌표에 사용하는 모델입니다
///// lat : 위도
///// lon: 경도
//struct Coordinate: Codable, Hashable{
//    let lat: String?
//    let lon: String?
//}
//
//struct Author: Codable, Hashable{
//    let userId: Int?
//    let username: String?
//    let profileImage: String?
//}

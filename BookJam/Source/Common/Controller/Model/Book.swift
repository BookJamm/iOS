//
//  Book.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

/// 출판물(책) 정보에 사용하는 모델입니다.
struct Book: Hashable {
    /// bookID : 책 ID
    var bookID: Int?
    /// place : 책 판매 서점
    var place: String?
    /// title : 책 제목
    var title: String?
    /// author : 책 저자 이름
    var author: String?
    /// cover : 책 커버 사진 URL
    var cover: String?
    /// genre : 책 장르
    var genre: String?
    /// price : 책 가격
    var price: String?
    /// isbn : ??
    var isbn: String?
    /// description : ??
    var description: String?
    /// publisher : 출판사
    var publisher: String?
}

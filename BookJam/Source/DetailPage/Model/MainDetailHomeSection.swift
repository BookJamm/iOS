//
//  MainDetailHomeSection.swift
//  BookJam
//
//  Created by 장준모 on 12/27/23.
//

import Foundation

//디테일 페이지 섹션 레이아웃
enum DetailSection: Hashable {
    case Home
    case Review
    case Activity
    case News(String)
    case BookList
}

//디테일 페이지 셀
enum Item: Hashable {
    case ReviewItem(Review)
    case ActivityItem(Activity)
    case NewsItem(News)
    case BookListItem(Book)
}

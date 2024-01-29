//
//  MainDetailHomeSection.swift
//  BookJam
//
//  Created by 장준모 on 12/27/23.
//

import Foundation
import RxDataSources

//디테일 페이지 섹션 레이아웃
enum DetailSection: Hashable {
    case Home
    case Review
    case Activity
    case News(String)
    case BookList
}
enum Item: Hashable {
    case ReviewItem(Review)
    case ActivityItem(Activity)
    case NewsItem(News)
    case BookListItem(Book)
}

//디테일 페이지 셀
enum SectionItem {
    case homeItem(DetailHomeTabModel)
    case newsItem(News)
    case activityItem(Activity)
    case reviewItem(Review)
    case bookListItem(Book)
}

struct MainDetailSectionModel {
    var header: String
    var items: [SectionItem]
}

extension MainDetailSectionModel: SectionModelType {
    typealias Item = SectionItem

    init(original: MainDetailSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}


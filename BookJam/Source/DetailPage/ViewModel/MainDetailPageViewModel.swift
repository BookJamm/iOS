//
//  MainDetailPageViewModel.swift
//  BookJam
//
//  Created by 장준모 on 11/15/23.
//

import Foundation
import RxSwift
import RxCocoa

final class MainDetailPageViewModel{
    let disposeBag = DisposeBag()
    
    struct Input {
        let homeTrigger: Observable<Void>
        let newsTrigger: BehaviorSubject<Void>
        let activityTrigger: Observable<Void>
        let reviewTrigger: Observable<Void>
        let bookListTrigger: Observable<Void>
    }
    
    struct Output {
        let homeAllList: Observable<Void>
        let newsList: Observable<Void>
        let activityList: Observable<Void>
        let reviewList: Observable<Void>
        let bookListList: Observable<Void>
    }
    
    let newsList = BehaviorRelay<[PlaceIdNewsResponseModel]>(value: [PlaceIdNewsResponseModel(newsId: 1, createdAt: "2022-22-22", updatedAt: "2022-22-22", title: "소식 제목", contents: "소식 제목", placeId: 1) ])
    
    
}

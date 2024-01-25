//
//  MainDetailPageViewModel.swift
//  BookJam
//
//  Created by 장준모 on 11/15/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

 class MainDetailPageViewModel{
    let disposeBag = DisposeBag()
    
     private let newsListRelay = BehaviorRelay<[News]>(value: [])

    struct Input {
        let homeTrigger: Observable<Void>
        let newsTrigger: Observable<Void>
        let activityTrigger: Observable<Void>
        let reviewTrigger: Observable<Void>
        let bookListTrigger: Observable<Void>
    }
    
    struct Output {
        let homeAllList: Observable<DetailHomeTabModel>
        let newsList: Observable<[News]>
        let activityList: Observable<[Activity]>
        let reviewList: Observable<[Review]>
        let bookListList: Observable<[Book]>
    }
    
     let placeId = PlaceId(placeId: 0, name: "천천히스미", category: 0, rating: 1.1, reviewCount: 111, website: "https://www.instagram.com/joonmoring", address: Address(road: "서울시 종로구 평창동 도로명", jibun: "서울시 종로구 평창동 지번"), images: [Image(id: 1, url: "https://www.google.com/url?sa=i&url=http%3A%2F%2Fwww.bhc.co.kr%2Fmenu%2Fchicken.asp&psig=AOvVaw0AkPNk05_jAJSLpBwwBwQj&ust=1705568056015000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKDFw6WG5IMDFQAAAAAdAAAAABAD")], open: true, bookmaked: false)
     let newsList = News(newsId: 1, createdAt: "2022-22-22", updatedAt: "2022-22-22", title: "하이하이", contents: "하이하이힝", placeId: 1)
     let bookList = Book(title: "진격의거인", author: "에렌 예거", cover: "https://image.aladin.co.kr/product/26/0/cover500/s742633278_1.jpg", isbn: "", description: "진격의거인", publisher: "출판사")
    let activityList = Activity(activityId: 1, createdAt: "2022", updatedAt: "2022", placeId: 1, title: "home", info: "good home", capacity: 1, headcount: 1, totalRating: 3.0, reviewCount: 3, imageUrl: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")
     let reviewList = Review(reviewId: 1, visitedAt: "2022 03 05", contents: "인테리어도 좋고 귀여운 아이템들도 있어서 아주 좋아요", rating: 5.0, images: [Image(id: 1, url: "https://i.namu.wiki/i/sQvSmVl3xla1olYzD7h4X_md8vEGv6SoiVeXGVralO3EbNWwTY1EZ2GVXkt5xO6J_2Xmxr8U7Uw-5ofFdufCcA.webp")], author: Author(userId: 1, username: "독서 광인", profileImage: nil))
     
    
    // MARK: Transform
    
     func transform(input: Input) -> Output {
         
         let homeResult = input.homeTrigger.flatMapLatest { [unowned self] _ -> Observable<DetailHomeTabModel> in
             return Observable.just(DetailHomeTabModel(homeList: self.placeId, bookList: [self.bookList], activityList: [self.activityList], reviewList: [self.reviewList], newsList: [self.newsList]  ))
         }
         

         input.newsTrigger
             .flatMapLatest { _ in
                 self.newsListRelay.accept([self.newsList])
                 return Observable.just(())
             }
             .subscribe()
             .disposed(by: disposeBag)
         
//         let news = input.newsTrigger.flatMapLatest { _ in
//             return Observable.just([self.newsList])
//         }
         

         let activity = input.activityTrigger.flatMapLatest { _ in
             return Observable.just([self.activityList])
         }

         let review = input.reviewTrigger.flatMapLatest { _ in
             return Observable.just([self.reviewList])
         }

         let book = input.bookListTrigger.flatMapLatest { _ in
             return Observable.just([self.bookList])
         }

         return Output(homeAllList: homeResult, newsList: newsListRelay.asObservable(), activityList: activity, reviewList: review, bookListList: book)
     }

}

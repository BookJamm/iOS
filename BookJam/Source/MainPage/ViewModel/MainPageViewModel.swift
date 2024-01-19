//
//  MainPageViewModel.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

import RxSwift
import CoreLocation
import RxRelay

final class MainPageViewModel: ViewModelType, MainPageDataProvider {
    
    var disposeBag = DisposeBag()
    
    
    // MARK: Input
    // Input 대신 internal로 선언한 state 3개로 transform을 진행합니다
    struct Input {
//        // 추후 화면 상단 알림, 광고배너 기획안 작성 완료시 추가해야합니다
//
//        /// 화면 상단 카테고리 선택 트리거
////        let categoryTrigger: Observable<Category>
//
//        /// 필터링 선택/
////        let selectFilter: Observable<CombinedSearchFilter>
//
////        let selectBookStoreFilter: Observable<BookStoreSearchFilter>
////        let selectBookClubFilter: Observable<BookClubSearchFilter>
////        let selectPublicationFilter: Observable<PublicationSearchFilter>
//
//
    }
    
    // MARK: Output
    struct Output {
        /// 서점 목록
        let bookStoreList: Observable<[Place]>
        /// 모임 목록
        let bookClubList: Observable<[BookClub]>
        /// 출판물 목록
        let publicationList: Observable<[Book]>
    }
    
    // MARK: State
    
    internal let selectedCategory = BehaviorRelay<Category>(value: .BookStore)
    
    internal let selectedFilter = BehaviorRelay<CombinedSearchFilter>(value: .distance)
    
    internal let searchbarTapEvent = PublishRelay<Void>()
    
    private let bookStoreList = BehaviorRelay<[Place]>(value: [Place(placeId: 0, name: "asdf", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205"))])
    
    private let bookClubList = BehaviorRelay<[BookClub]>(value: [BookClub(bookClubID: 0, name: "asdf", date: Date(), cover: "asdf", place: "asdf", type: "asdf")])
    
    private let PublicationList = BehaviorRelay<[Book]>(value: [Book(bookID: 0, place: "asdf", title: "asdf", author: "asdf", cover: "asdf", genre: "asdf", price: "0912", isbn: "asdf", description: ":asdf", publisher: "asdf")])
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        // 카테고리 선택 input시 state에 반영
//        input.categoryTrigger
//            .bind(to: selectedCategory)
//            .disposed(by: disposeBag)
//
        // 필터 선택 input시 state에 반영
//        input.selectFilter
//            .bind(to: selectedFilter)
//            .disposed(by: disposeBag)
            
        // 카테고리가 변경될 때마다 필터를 해당 카테고리의 기본 필터로 변경
        selectedCategory
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] category in
                if let defaultFilter = category.filters.first {  // 해당 카테고리의 기본 필터를 얻음
                    self?.selectedFilter.accept(defaultFilter)
                }
            })
            .disposed(by: disposeBag)
        
        // 카테고리 선택 or 필터 선택시 API+리턴 수행
        selectedFilter
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.asyncInstance)
            .flatMap { [weak self] selectedFilter -> Observable<Any> in
                guard let category = self?.selectedCategory.value else { return Observable.empty() }
                
                print("conducting API with category:\(category), filter:\(selectedFilter)")
                
                switch category {
                case .BookStore:
                    //                return APIManager.shared.requestData(
                    //                    endpoint: .getPlaces,
                    //                    requestData: Place,
                    //                    requestDataType: PlacesRequestModel.self,
                    //                    responseDataType: [PlacesResponseModel].self
                    //                )
                    //                .catchErrorJustReturn([]) // 나중에 빼거나.. else
                    //                .map { resModel in
                    //                    return resModel.map { $0.toDomain() }
                    //                }
                    return Observable.just([Place(placeId: 0, name: "BookStore1", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                            Place(placeId: 1, name: "BookStore2", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                            Place(placeId: 0, name: "BookStore3", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                            Place(placeId: 1, name: "BookStore4", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                            Place(placeId: 0, name: "BookStore5", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                            Place(placeId: 1, name: "BookStore6", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil)])
                    
                case .BookClub:
                    // API 나오면 작성
                    return Observable.just([BookClub(bookClubID: 0, name: "BookClub2", date: nil, cover: nil, place: nil, type: nil),
                                            BookClub(bookClubID: 1, name: "BookClub3", date: nil, cover: nil, place: nil, type: nil),
                                            BookClub(bookClubID: 2, name: "BookClub4", date: nil, cover: nil, place: nil, type: nil),
                                            BookClub(bookClubID: 3, name: "BookClub5", date: nil, cover: nil, place: nil, type: nil),
                                            BookClub(bookClubID: 4, name: "BookClub6", date: nil, cover: nil, place: nil, type: nil),
                                            BookClub(bookClubID: 5, name: "BookClub7", date: nil, cover: nil, place: nil, type: nil)])
                    
                case .Publication:
                    // API 나오면 작성
                    return Observable.just([Book(bookID: 0, place: nil, title: "Publication3", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                            Book(bookID: 1, place: nil, title: "Publication4", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                            Book(bookID: 3, place: nil, title: "Publication5", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                            Book(bookID: 4, place: nil, title: "Publication6", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                            Book(bookID: 5, place: nil, title: "Publication7", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                            Book(bookID: 6, place: nil, title: "Publication8", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)])
                }
            }
            .subscribe(onNext: { [weak self] data in
//                print(data)
                // Behavior Relay에 값을 업데이트
                if let places = data as? [Place] {
//                    print("bookStoreList : \(places)")
                    self?.bookStoreList.accept(places)
//                    print(self?.bookStoreList.value)
                }
                
                if let clubs = data as? [BookClub] {
//                    print("bookClubList: \(clubs)")
                    self?.bookClubList.accept(clubs)
                }
                
                if let books = data as? [Book] {
//                    print("PublicationList: \(books)")
                    self?.PublicationList.accept(books)
                }
            })
            .disposed(by: disposeBag)
            
            return Output(
                bookStoreList: bookStoreList.asObservable(), // viewModel 안에서 생성한 State를 Output
                bookClubList: bookClubList.asObservable(),
                publicationList: PublicationList.asObservable()
            )
        
        
        // 카테고리 선택 or 필터 선택시 API+리턴 수행
//        Observable.combineLatest(
//            selectedCategory,
//            selectedFilter.distinctUntilChanged()
//        )
//        .flatMap { (category, selectFilter) -> Observable<Any> in
//            print("conducting API with category:\(category), filter:\(selectFilter)")
//            switch category {
//                
//            case .BookStore:
////                return APIManager.shared.requestData(
////                    endpoint: .getPlaces,
////                    requestData: Place,
////                    requestDataType: PlacesRequestModel.self,
////                    responseDataType: [PlacesResponseModel].self
////                )
////                .catchErrorJustReturn([]) // 나중에 빼거나.. else
////                .map { resModel in
////                    return resModel.map { $0.toDomain() }
////                }
//                return Observable.just([BookClub(bookClubID: 0, name: nil, date: nil, cover: nil, place: nil, type: nil)])
//                
//            case .BookClub:
//                // API 나오면 작성
//                return Observable.just([BookClub(bookClubID: 0, name: nil, date: nil, cover: nil, place: nil, type: nil)])
//                
//            case .Publication:
//                // API 나오면 작성
//                return Observable.just([Book(bookID: 0, place: nil, title: nil, author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)])
//            }
//                
//        }
//        .subscribe(onNext: { [weak self] data in
//            // Behavior Relay에 값을 업데이트
//            if let places = data as? [Place] {
//                self?.bookStoreList.accept(places)
//            }
//            
//            if let clubs = data as? [BookClub] {
//                self?.bookClubList.accept(clubs)
//            }
//            
//            if let books = data as? [Book] {
//                self?.PublicationList.accept(books)
//            }
//        })
//        .disposed(by: disposeBag)
//        
//        return Output(
//            selectedCategory: selectedCategory.asObservable(),
//            selectedFilter: selectedFilter.asObservable(),
//            bookStoreList: bookStoreList.asObservable(), // viewModel 안에서 생성한 State를 Output
//            bookClubList: bookClubList.asObservable(),
//            publicationList: PublicationList.asObservable()
//        )
        
    }
}

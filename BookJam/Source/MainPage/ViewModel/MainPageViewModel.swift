//
//  MainPageViewModel.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

import RxSwift
import CoreLocation
import RxRelay

final class MainPageViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    // MARK: Input
    struct Input {
        // 추후 화면 상단 알림, 광고배너 기획안 작성 완료시 추가해야합니다
        
        /// 화면 상단 카테고리 선택 트리거
        let categoryTrigger: Observable<Category>
        
        /// 필터링 선택
        let selectFilter: Observable<CombinedSearchFilter>
        
//        let selectBookStoreFilter: Observable<BookStoreSearchFilter>
//        let selectBookClubFilter: Observable<BookClubSearchFilter>
//        let selectPublicationFilter: Observable<PublicationSearchFilter>
       
        
    }
    
    // MARK: Output
    struct Output {
        /// 선택된 카테고리
        let selectedCategory: Observable<Category>
        /// 선택된 필터
        let selectedFilter: Observable<CombinedSearchFilter>
        /// 서점 목록
        let bookStoreList: Observable<[Place]>
//        /// 모임 목록
        let bookClubList: Observable<[BookClub]>
//        /// 출판물 목록
        let publicationList: Observable<[Book]>
    }
    
    // MARK: State

    private let selectedCategory = BehaviorRelay<Category>(value: .BookStore)
    
    private let selectedFilter = BehaviorRelay<CombinedSearchFilter>(value: .distance)
    
    private let bookStoreList = BehaviorRelay<[Place]>(value: [Place(placeId: 0, name: "asdf", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205"))])
    
    private let bookClubList = BehaviorRelay<[BookClub]>(value: [BookClub(bookClubID: 0, name: "asdf", date: Date(), cover: "asdf", place: "asdf", type: "asdf")])
    
    private let PublicationList = BehaviorRelay<[Book]>(value: [Book(bookID: 0, place: "asdf", title: "asdf", author: "asdf", cover: "asdf", genre: "asdf", price: "0912", isbn: "asdf", description: ":asdf", publisher: "asdf")])
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        // 카테고리 선택 input시 state에 반영
        input.categoryTrigger
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        // 필터 선택 input시 state에 반영
        input.selectFilter
            .bind(to: selectedFilter)
            .disposed(by: disposeBag)
        
        // 카테고리 선택 or 필터 선택시 API+리턴 수행
        Observable.combineLatest(
//            input.categoryTrigger,
//            input.selectFilter
            selectedCategory,
            selectedFilter
        )
        .flatMap { (category, selectFilter) -> Observable<Any> in
            switch category {
                
            case .BookStore:
                return APIManager.shared.requestData(
                    endpoint: .getPlaces,
                    requestData: nil,
                    requestDataType: PlacesRequestModel.self,
                    responseDataType: [PlacesResponseModel].self
                )
                .catchErrorJustReturn([]) // 나중에 빼거나.. else
                .map { resModel in
                    return resModel.map { $0.toDomain() }
                }
                
            case .BookClub:
                // API 나오면 작성
                return Observable.just([BookClub(bookClubID: 0, name: nil, date: nil, cover: nil, place: nil, type: nil)])
                
            case .Publication:
                // API 나오면 작성
                return Observable.just([Book(bookID: 0, place: nil, title: nil, author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)])
            }
                
        }
        .subscribe(onNext: { [weak self] data in
            // Behavior Relay에 값을 업데이트
            if let places = data as? [Place] {
                self?.bookStoreList.accept(places)
            }
            
            if let clubs = data as? [BookClub] {
                self?.bookClubList.accept(clubs)
            }
            
            if let books = data as? [Book] {
                self?.PublicationList.accept(books)
            }
        })
        .disposed(by: disposeBag)
        
        return Output(
            selectedCategory: selectedCategory.asObservable(),
            selectedFilter: selectedFilter.asObservable(),
            bookStoreList: bookStoreList.asObservable(),
            bookClubList: bookClubList.asObservable(),
            publicationList: PublicationList.asObservable()
        )
        
    }
}

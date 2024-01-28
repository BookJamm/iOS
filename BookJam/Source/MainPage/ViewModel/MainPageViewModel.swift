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
//    internal let selectedCategory = PublishRelay<Category>()
    
    internal let selectedFilter = BehaviorRelay<CombinedSearchFilter>(value: .distance)
//    internal let selectedFilter = PublishRelay<CombinedSearchFilter>()
    
    internal let searchbarTapEvent = PublishRelay<Void>()
    
    internal let selectedClubCategory = BehaviorRelay<[BookClubCategory]>(value: BookClubCategory.allCases)
    
    private let bookStoreList = PublishRelay<[Place]>()
    private let bookClubList = PublishRelay<[BookClub]>()
    private let PublicationList = PublishRelay<[Book]>()
    
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
        
        searchbarTapEvent
            .bind { _ in
                print("searchBarTapped")
            }
            .disposed(by: disposeBag)
        // MARK: ------------Start of Re-Code-------------
        // 카테고리가 변경될 때마다 필터를 해당 카테고리의 기본 필터로 변경
        selectedCategory
//            .distinctUntilChanged() // 얘 때문에 안되던 것
            .subscribe(onNext: { [weak self] category in
                if let defaultFilter = category.filters.first {  // 해당 카테고리의 기본 필터를 얻음
                    self?.selectedFilter.accept(defaultFilter)
                }
            })
            .disposed(by: disposeBag)
        
        // 카테고리 선택 or 필터 선택시 API+리턴 수행
        selectedFilter
//            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.asyncInstance) // 얘 때문에 안되던 것
            .bind { [weak self] selectedFilter in
                guard let category = self?.selectedCategory.value else { return }
                print("conducting API-Call / Category: \(category), Filter: \(selectedFilter)")
                
                switch category {
                case .BookStore:
                    self?.getBookStoreList(filter: selectedFilter)
                        .subscribe(onNext: { places in
                            self?.bookStoreList.accept(places)
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                case .BookClub:
                    if let clubCategory = self?.selectedClubCategory.value {
                        self?.getBookClubList(clubCategory: clubCategory, filter: selectedFilter)
                            .subscribe(onNext: { clubs in
                                self?.bookClubList.accept(clubs)
                            })
                            .disposed(by: self?.disposeBag ?? DisposeBag())
                    }
                case .Publication:
                    self?.getBookList(filter: selectedFilter)
                        .subscribe(onNext: { books in
                            self?.PublicationList.accept(books)
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
            }
            .disposed(by: disposeBag)

            return Output(
                bookStoreList: bookStoreList.asObservable(), // viewModel 안에서 생성한 State를 Output
                bookClubList: bookClubList.asObservable(),
                publicationList: PublicationList.asObservable()
            )
            // MARK: ------------End of Re-Code-------------
        
        selectedClubCategory
            .bind { [weak self] selectedClubCategory in
                print("선택된 모임 카테고리 : \(selectedClubCategory)")
                if let defaultFilter = Category.BookClub.filters.first {  // 해당 카테고리의 기본 필터를 얻음
                    self?.selectedFilter.accept(defaultFilter)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: API Call
    private func getBookStoreList(filter:CombinedSearchFilter) -> Observable<[Place]> {
//        return APIManager.shared.requestData(
//            endpoint: .getPlaces,
//            requestData: Place,
//            requestDataType: PlacesRequestModel.self,
//            responseDataType: [PlacesResponseModel].self
//        )
//        .catchErrorJustReturn([]) // 나중에 빼거나.. else
//        .map { resModel in
//            return resModel.map { $0.toDomain() }
//        }
        return Observable.just([Place(placeId: 0, name: "BookStore1", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore2", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 0, name: "BookStore3", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore4", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 0, name: "BookStore5", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore6", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil)])
    }
    
    private func getBookClubList(clubCategory: [BookClubCategory], filter:CombinedSearchFilter) -> Observable<[BookClub]> {
        return Observable.just([BookClub(bookClubID: 0, name: "BookClub2", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 1, name: "BookClub3", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 2, name: "BookClub4", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 3, name: "BookClub5", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 4, name: "BookClub6", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 5, name: "BookClub7", date: nil, cover: nil, place: nil, type: nil)])
        
    }
    
    private func getBookList(filter:CombinedSearchFilter) -> Observable<[Book]> {
        return Observable.just([Book(bookID: 0, place: nil, title: "Publication3", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 1, place: nil, title: "Publication4", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 3, place: nil, title: "Publication5", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 4, place: nil, title: "Publication6", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 5, place: nil, title: "Publication7", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 6, place: nil, title: "Publication8", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)])
        
    }
}

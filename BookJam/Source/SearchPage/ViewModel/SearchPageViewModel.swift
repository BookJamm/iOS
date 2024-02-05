//
//  SearchPageViewModel.swift
//  BookJam
//
//  Created by 박민서 on 2/6/24.
//

import RxSwift
import CoreLocation
import RxRelay

final class SearchPageViewModel: ViewModelType, SearchPageDataProvider {
    
    var disposeBag = DisposeBag()
    
    
    // MARK: Input
    // Input 대신 internal로 선언한 state 3개로 transform을 진행합니다
    struct Input {
        /// 서치바 검색 input
        let searchText: Observable<String>
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
    /// (String,Int) 형의 구조체로 올지, 각 리스트의 개수를 세야할 지 확실치 않음.
    /// 추후 API 명세서 나오면 추가작업 필요
    internal let searchResult = PublishRelay<(String,Int)>()
    
    private let bookStoreList = PublishRelay<[Place]>()
    private let bookClubList = PublishRelay<[BookClub]>()
    private let PublicationList = PublishRelay<[Book]>()
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        
        input.searchText
            .flatMap { [weak self] text in
                return Observable.zip(
                    self?.getBookStoreList(text: text) ?? .empty(), // 비동기 함수가 nil인 경우
                    self?.getBookClubList(text: text) ?? .empty(),
                    self?.getBookList(text: text) ?? .empty(),
                    self?.getTotalCountList(text: text) ?? .empty()
                )
            }
            .bind { [weak self] searchResult in
                self?.bookStoreList.accept(searchResult.0)
                self?.bookClubList.accept(searchResult.1)
                self?.PublicationList.accept(searchResult.2)
                self?.searchResult.accept(searchResult.3)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            bookStoreList: bookStoreList.asObservable(),
            bookClubList: bookClubList.asObservable(),
            publicationList: PublicationList.asObservable()
        )
    }
    
    // MARK: API Call
    private func getTotalCountList(text: text) -> Observable<(String,Int)> {
        return Observable
            .just((text, 12))
    }
    
    
    private func getBookStoreList(text:String) -> Observable<[Place]> {
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
        return Observable
            .just([Place(placeId: 0, name: "BookStore1", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore2", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 0, name: "BookStore3", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore4", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 0, name: "BookStore5", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil),
                                Place(placeId: 1, name: "BookStore6", rating: 0.0, reviewCount: 0, category: 0, open: false, images: nil, address: nil, coords: nil)])
//            .flatMap { places in
//                return Observable.just(Array(places.prefix(2)))
//            }
    }
    
    private func getBookClubList(text:String) -> Observable<[BookClub]> {
        return Observable
            .just([BookClub(bookClubID: 0, name: "BookClub2", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 1, name: "BookClub3", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 2, name: "BookClub4", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 3, name: "BookClub5", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 4, name: "BookClub6", date: nil, cover: nil, place: nil, type: nil),
                                BookClub(bookClubID: 5, name: "BookClub7", date: nil, cover: nil, place: nil, type: nil)])
//            .flatMap { bookClubs in
//                return Observable.just(Array(bookClubs.prefix(2)))
//            }
    }
    
    private func getBookList(text:String) -> Observable<[Book]> {
        return Observable
            .just([Book(bookID: 0, place: nil, title: "Publication3", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 1, place: nil, title: "Publication4", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 3, place: nil, title: "Publication5", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 4, place: nil, title: "Publication6", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 5, place: nil, title: "Publication7", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil),
                                Book(bookID: 6, place: nil, title: "Publication8", author: nil, cover: nil, genre: nil, price: nil, isbn: nil, description: nil, publisher: nil)])
//            .flatMap { books in
//                return Observable.just(Array(books.prefix(2)))
//            }
    }
}

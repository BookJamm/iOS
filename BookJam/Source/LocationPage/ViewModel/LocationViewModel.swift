//
//  LoctionViewModel.swift
//  BookJam
//
//  Created by 박민서 on 12/2/23.
//

import RxSwift
import CoreLocation
import RxRelay
import MapKit

final class LocationViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    // MARK: Input
    struct Input {
        /// 현재위치에서 재탐색 트리거
        let refreshTrigger: Observable<Void>
    }
    
    // MARK: Output
    struct Output {
        /// 서점 목록
        let bookStoreList: Observable<[Place]>
        /// 지도에 표시되는 서점 목록
        let bookStoreAnnotationList: Observable<[MKAnnotation]>
    }
    
    // MARK: State
    let bookStoreList = BehaviorRelay<[Place]>(value: [Place(placeId: 0, name: "asdf", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205"))])
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        
        input.refreshTrigger.flatMapLatest {
            
            // MARK: API 나오면 테스트
            //            return APIManager.shared.requestData(
            //                endpoint: .getPlaces,
            //                requestData: PlacesRequestModel(category: 0, sortBy: "ㅁㄴㅇㄹ", lat: 0.0, lon: 0.0, last: 0),
            //                responseDataType: [PlacesResponseModel].self)
            //            .map {
            //                //Observable<[PlacesResponseModel]> -> Observable<[Place]>
            //                $0.map { $0.toDomain() }
            //            }
            
            // MARK: 더미 데이터 리턴
            return Observable.just([
                Place(placeId: 0, name: "asdf", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.493421", lon: "126.829205")),
                Place(placeId: 0, name: "sdfg", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.492475", lon: "126.822224")),
                Place(placeId: 0, name: "erty", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.491424", lon: "126.823232")),
                Place(placeId: 0, name: "vghm", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.497443", lon: "126.826243")),
                Place(placeId: 0, name: "huil", rating: 0.0, reviewCount: 0, category: 0, open: true, images: nil, address: nil, coords: Coordinate(lat: "37.498412", lon: "126.827221"))
            ])
        }.bind(to: bookStoreList).disposed(by: disposeBag)
        
        // MARK: bookStoreList transform -> Annotation에 활용
        let bookStoreAnnotationList = bookStoreList.flatMapLatest { placeList -> Observable<[MKAnnotation]> in
            return Observable.just(
                placeList.map { place -> MKAnnotation in
                    let pin = MKPointAnnotation()
                    if let lat = place.coords?.lat, let lon = place.coords?.lon {
                        pin.coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0)
                        pin.title = place.name
                        pin.subtitle = LocationCategory(rawValue: place.category ?? 0)?.inKorean
                    }
                    return pin
                }
            )
        }
            
        return Output(bookStoreList: bookStoreList.asObservable(), bookStoreAnnotationList: bookStoreAnnotationList)
    }
}

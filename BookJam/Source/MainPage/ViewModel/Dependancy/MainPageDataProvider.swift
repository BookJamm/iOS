//
//  MainPageDataProvider.swift
//  BookJam
//
//  Created by 박민서 on 1/10/24.
//

import RxSwift
import RxRelay

/// MainPage의 ViewModel간 데이터 흐름을 위한 프로토콜입니다.
/// MainPage 내부의 컴포넌트에서 관리되어야 하는 데이터 흐름을 작성합니다.
protocol MainPageDataProvider {
    
    /// Rx - Category 선택 emitted from MainPageCollectionHeaderViewModel
    var selectedCategory: BehaviorRelay<Category> { get }
    
    /// Rx - Filter 선택 emitted from MainPageCollectionHeaderViewModel
    var selectedFilter: BehaviorRelay<CombinedSearchFilter> { get }
    
    /// Rx - 서치바 탭 이벤트 emitted from MainPageTopViewModel
    var searchbarTapEvent: PublishRelay<Void> { get }

}

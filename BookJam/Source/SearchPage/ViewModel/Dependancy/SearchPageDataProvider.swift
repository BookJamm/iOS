//
//  SearchPageDataProvider.swift
//  BookJam
//
//  Created by 박민서 on 2/6/24.
//

import RxSwift
import RxRelay

/// SearchPage의 ViewModel간 데이터 흐름을 위한 프로토콜입니다.
/// SearchPage 내부의 컴포넌트에서 관리되어야 하는 데이터 흐름을 작성합니다.
protocol SearchPageDataProvider {

    /// Rx - 서치 검색 결과 from SearchPageViewModel
    var searchResult: PublishRelay<(String,Int)> { get }

}

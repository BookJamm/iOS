//
//  SearchPageResultCountViewModel.swift
//  BookJam
//
//  Created by 박민서 on 2/6/24.
//

import RxSwift
import RxRelay


final class SearchPageResultCountViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    
    // MARK: Dependancy
    let dataProvider: SearchPageDataProvider
    
    init(dataProvider: SearchPageDataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: Input
    struct Input {
    }
    
    // MARK: Output
    struct Output {
        /// 보여지는 검색 텍스트 + 결과 수
        let result: Observable<(String,Int)>
    }
    
    // MARK: Transfrom
    func transform(input: Input) -> Output {
        return Output(result: dataProvider.searchResult.asObservable())
    }
}

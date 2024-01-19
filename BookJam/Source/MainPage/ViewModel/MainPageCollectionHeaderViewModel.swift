//
//  MainPageCollectionHeaderViewModel.swift
//  BookJam
//
//  Created by 박민서 on 1/3/24.
//

import RxSwift

final class MainPageCollectionHeaderViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    
    // MARK: Dependancy
    let dataProvider: MainPageDataProvider
    
    init(dataProvider: MainPageDataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: Input
    struct Input {
        
        /// 필터 선택 이벤트 from self
        let filterSelectEvent : Observable<CombinedSearchFilter>
        
        /// 선택된 카테고리 주입 from MainPageViewModel
//        let selectedCategory: Observable<Category>
        
    }
    
    // MARK: Output
    struct Output {
        
        /// 필터 선택 이벤트 to MainPageViewModel
//        let selectedFilter : Observable<CombinedSearchFilter>
        
        /// 보여질 필터 목록 to self
        let filters: Observable<[CombinedSearchFilter]>
        
        /// 보여질 소개 문구 to self
        let infoText: Observable<String>
    }
    
    // MARK: Transfrom
    func transform(input: Input) -> Output {
        
        input.filterSelectEvent
            .bind(to: dataProvider.selectedFilter)
            .disposed(by: disposeBag)
        
        // 카테고리 -> 필터 목록
        let filters = dataProvider.selectedCategory.map { $0.filters }
        
        // 카테고리 -> 소개 문구
        let infoText = dataProvider.selectedCategory.map { $0.infoComment }
        
        return Output(
            filters: filters, 
            infoText: infoText
        )
    }
}

//
//  MainPageClubCategoryViewModel.swift
//  BookJam
//
//  Created by 박민서 on 1/28/24.
//

import RxSwift

final class MainPageClubCategoryViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    
    // MARK: Dependancy
    let dataProvider: MainPageDataProvider
    
    init(dataProvider: MainPageDataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: Input
    struct Input {
        
        /// 모임 카테고리 선택 이벤트 from self
        let categorySelectEvent : Observable<BookClubCategory>
        
    }
    
    // MARK: Output
    struct Output {
        
        /// 보여질 필터 목록 to self
        let selectedClubCategory: Observable<[BookClubCategory]>
        
    }
    
    // MARK: Transfrom
    func transform(input: Input) -> Output {
        
    }
}

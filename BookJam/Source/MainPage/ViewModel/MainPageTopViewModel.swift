//
//  MainPageTopViewModel.swift
//  BookJam
//
//  Created by 박민서 on 1/3/24.
//

import RxSwift
import RxRelay

final class MainPageTopViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    
    // MARK: Dependancy
    let dataProvider: MainPageDataProvider?
    
    init(dataProvider: MainPageDataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: Input
    struct Input {
        
        /// 서치바 탭 트리거 from self
        let searchTrigger: Observable<Void>
        
        /// 카테고리 선택 트리거 from self
        let categoryTrigger: Observable<Category>
    }
    
    // MARK: Output
    struct Output {
        
        /// 서치바 탭 트리거 to MainPage
//        let searchTrigger: Observable<Void>
        
        /// 카테고리 선택 트리거 to MainPage
        let selectedCategory: Observable<Category>
    }
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        
        if let dataProvider = self.dataProvider {
                    
            input.searchTrigger
                .bind(to: dataProvider.searchbarTapEvent)
                .disposed(by: disposeBag)
            
            input.categoryTrigger
                .bind(to: dataProvider.selectedCategory)
                .disposed(by: disposeBag)
            
            return Output(selectedCategory: dataProvider.selectedCategory.asObservable())
        }
    
        return Output(selectedCategory: input.categoryTrigger)
    }
}

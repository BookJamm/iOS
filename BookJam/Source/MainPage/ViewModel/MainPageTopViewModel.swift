//
//  MainPageTopViewModel.swift
//  BookJam
//
//  Created by 박민서 on 1/3/24.
//

import RxSwift
import RxRelay

/// MainPageTopViewModel -> MainPageViewModel
/// 단방향 전달 구조 / emitter의 역할만 수행하므로, 사용하지 않습니다.
final class MainPageTopViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    // MARK: Input
    struct Input {
        
        /// 서치바 탭 트리거
        let searchTrigger: Observable<Void>
        
        /// 카테고리 선택 트리거
        let categoryTrigger: Observable<Category>
    }
    
    // MARK: Output
    struct Output {
        
        /// 서치바 탭 트리거 to MainPage
        let searchTrigger: Observable<Void>
        
        /// 카테고리 선택 트리거 to MainPage
        let categoryTrigger: Observable<Category>
    }
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        return Output(
            searchTrigger: input.searchTrigger,
            categoryTrigger: input.categoryTrigger)
    }
}

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
    let dataProvider: MainPageDataProvider?
    
    init(dataProvider: MainPageDataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: Input
    struct Input {
        /// 모임 카테고리 선택 이벤트 from self
        let clubCategorySelectEvent: Observable<BookClubCategory>
        /// 모임 카테고리 전체 선택 이벤트 from self
        let clubCategorySelectAllEvent: Observable<Void>
    }
    
    // MARK: Output
    struct Output {
        /// 보여질 선택된 카테고리 목록 from MainiPageDataProvider
        let selectedClubCategory: Observable<[BookClubCategory]>
    }
    
    // MARK: Transfrom
    func transform(input: Input) -> Output {
        guard let dataProvider = self.dataProvider else { 
            return Output.init(selectedClubCategory: Observable.just([]))
        }
        
        // 전체 버튼을 눌렀을 때
        input.clubCategorySelectAllEvent
            .bind {
                dataProvider.selectedClubCategory.accept(BookClubCategory.allCases)
            }
            .disposed(by: disposeBag)
        
        // 전체 외 개별 카테고리 선택했을 때
        input.clubCategorySelectEvent
            .bind { clubCategory in
                var selectedList = dataProvider.selectedClubCategory.value
                
                // 선택된 아이템이 추가/삭제인지 확인하여 list에 반영합니다.
                if let index = selectedList.firstIndex(of: clubCategory) {
                    selectedList.remove(at: index)
                } else {
                    selectedList.append(clubCategory)
                }
                
                dataProvider.selectedClubCategory.accept(selectedList)
            }
            .disposed(by: disposeBag)
        
        return Output.init(selectedClubCategory: dataProvider.selectedClubCategory.asObservable())
    }
}

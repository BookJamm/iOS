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
//        let clubCategorySelectAllEvent: Observable<Void>
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
//        input.clubCategorySelectAllEvent
//            .bind {
//                dataProvider.selectedClubCategory.accept(BookClubCategory.allCases)
//            }
//            .disposed(by: disposeBag)
        
        // 카테고리 선택했을 때
        input.clubCategorySelectEvent
            .subscribe(onNext: { clubCategory in
                // "전체" 선택한 경우
                if clubCategory == .all {
                    dataProvider.selectedClubCategory.accept([.all])
                }
                // 개별 카테고리 선택한 경우
                else {
                    var selectedList = dataProvider.selectedClubCategory.value
                    if let test = selectedList.firstIndex(of: .all) {
                        // .all이 이미 selectedList에 있는 경우
                        selectedList.remove(at: test)
                    }
                    // 선택된 아이템이 추가/삭제인지 확인하여 list에 반영합니다.
                    if let index = selectedList.firstIndex(of: clubCategory) {
                        // clubCategory가 이미 selectedList에 있는 경우
                        selectedList.remove(at: index)
                    } else {
                        // 포함되지 않은 경우
                        selectedList.append(clubCategory)
                    }
                    dataProvider.selectedClubCategory.accept(selectedList)
                }
            })
            .disposed(by: disposeBag)
        
        return Output.init(selectedClubCategory: dataProvider.selectedClubCategory.asObservable())
    }
}

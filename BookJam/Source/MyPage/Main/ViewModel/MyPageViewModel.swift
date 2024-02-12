//
//  MyPageViewModel.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

import RxSwift
import RxRelay

final class MyPageViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    // MARK: Input
    struct Input {
        /// 알림 설정
        let setNotificationSetting: Observable<Bool>
    }
    
    // MARK: Output
    struct Output {
        /// 프로필
        let profile: Observable<UserProfile>
    }
    
    // MARK: Status
    /// 알림 설정 상태
    private let notificationSetting = BehaviorRelay<Bool>(value: false)
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        
        input.setNotificationSetting
            .bind(onNext: { [weak self] val in
                self?.postNotificationSetting(val: val)
                    .bind(onNext: { result in
                        self?.notificationSetting.accept(result)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: self.disposeBag)
        
        return Output(profile: getMyProfile())
    }
    
    // MARK: API Call
    private func getMyProfile() -> Observable<UserProfile> {
        return Observable.just(
            UserProfile(
                userId: 0,
                image: nil,
                name: "test",
                userEmail: "asdf@naver.com",
                notificationSetting: false
            ))
    }
    
    private func postNotificationSetting(val: Bool) -> Observable<Bool> {
        // 서버에서 서버알림설정 변경 뒤 response로 변경 값 return 받음
        return Observable.just(val)
    }
}

//
//  MainPageTopView.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class MainPageTopView: UICollectionViewCell {
    
    // MARK: Variables
    
    static let id = "MainPageTopView"
    
    // Rx - DisposeBag
    let disposeBag = DisposeBag()
    
    // Rx - 서치바 탭 이벤트 - emiter
    let seachBarTapEvent = PublishSubject<Void>()
    
    // Rx - 카테고리 버튼 탭 이벤트 - emiter
    let categorySelectEvent = PublishSubject<Category>()
    
    /// 상단 서치바
    private lazy var searchBar: SearhBarButton = SearhBarButton(placeHolder: "상호명 또는 주소 검색").then {
        $0.contentHorizontalAlignment = .leading
    }
    
    /// 중간 분리줄
    private var borderLine:UIView = UIView().then {
        $0.backgroundColor = .gray03
    }
    
    /// 독립서점 버튼
    lazy var bookStoreButton = CategoryButton(category: .BookStore)
    /// 모임 버튼
    lazy var bookClubButton = CategoryButton(category: .BookClub)
    /// 출판물 버튼
    lazy var publicationButton = CategoryButton(category: .Publication)
    
    /// 카테고리 버튼 3개 들어가는 스택뷰
    private lazy var categoryStackView: UIStackView = UIStackView(arrangedSubviews: [
        bookStoreButton,
        bookClubButton,
        publicationButton
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpBinding()
        setUpLayout()
        setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.backgroundColor = .white
    }
    
    private func setUpBinding() {
        
        // 서치바 버튼 Tap Event 바인딩
        searchBar.rx.tap
            .bind(to: seachBarTapEvent)
            .disposed(by: disposeBag)
        
        // 카테고리 버튼 Event 바인딩
        Observable.merge(
            bookStoreButton.rx.tap.map { Category.BookStore },
            bookClubButton.rx.tap.map { Category.BookClub },
            publicationButton.rx.tap.map { Category.Publication }
        )
        .bind(to: categorySelectEvent)
        .disposed(by: disposeBag)
        
        // 카테고리 선택따라서 버튼스택 UI 변경
        self.categorySelectEvent
            .map { category -> (isBookStore: Bool, isBookClub: Bool, isPublication: Bool) in
                print(category)
                switch category {
                case .BookStore : return (true,false,false)
                case .BookClub : return (false,true,false)
                case .Publication : return (false,false,true)
                }
            }
            .bind { isBookStore, isBookClub, isPublication in
                self.bookStoreButton.isOn = isBookStore
                self.bookClubButton.isOn = isBookClub
                self.publicationButton.isOn = isPublication
                print("CategorySelectEvent Evoked")
            }
            .disposed(by: self.disposeBag)
             
        // Test용
        self.seachBarTapEvent.subscribe(
            onNext: {
                print("SearchButtonTapEvent Evoked")
            },
            onError: {_ in 
                print("Error Evoked")
            },
            onCompleted: {
                print("Complete Evoked")
            },
            onDisposed: {
                print("Disposede")
            }
        )
        .disposed(by: disposeBag)
    }
    
    private func setUpLayout() {
        [
            searchBar,
            borderLine,
            categoryStackView
        ].forEach { self.addSubview($0)}
        
    }
    
    private func setUpConstraint() {
        
         searchBar.snp.makeConstraints {
             $0.top.equalToSuperview().offset(12)
             $0.leading.equalToSuperview().offset(20)
             $0.trailing.equalToSuperview().offset(-20)
             $0.height.equalTo(44)
         }
         
         borderLine.snp.makeConstraints {
             $0.top.equalTo(searchBar.snp.bottom).offset(12)
             $0.horizontalEdges.equalToSuperview()
             $0.height.equalTo(1)
         }
         
         categoryStackView.snp.makeConstraints {
             $0.top.equalTo(borderLine.snp.bottom).offset(16)
             $0.leading.equalToSuperview().offset(20)
             $0.trailing.equalToSuperview().offset(-20)
             $0.height.equalTo(80)
         }
    }
}

@available(iOS 17.0, *)
#Preview {
    MainPageTopView()
}

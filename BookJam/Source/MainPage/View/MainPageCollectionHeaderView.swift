//
//  MainPageCollectionHeaderView.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxRelay

final class MainPageCollectionHeaderView: UICollectionReusableView {
    
    // MARK: Variables
    static let id = "MainPageCollectionHeaderView"
    
    // Rx - DisposeBag
    let disposeBag = DisposeBag()
    
    // Rx - 필터 선택 이벤트 to MainPageViewModel - emiter
    var filterSelectEvent = PublishSubject<CombinedSearchFilter>()
    
    // Rx - 선택된 카테고리 주입 from MainPageViewModel - subscriber
    var selectedCategory = PublishSubject<Category>()
    
    // Rx - ViewModel
    private var viewModel = MainPageCollectionHeaderViewModel()
    
    var filterList: [String]? {
        didSet {
//            print(filterList)
            refreshFilter()
        }
    }
    
    var infoText: String? {
        didSet {
//            print(infoText)
            refreshInfoText()
        }
    }
    
    private lazy var filterButton: UIButton = UIButton().then {

        // image 설정
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 14, weight: .light, scale: .small)
        
        // button 설정
        var buttonConfig = UIButton.Configuration.bordered()
        buttonConfig.baseForegroundColor = gray07
        buttonConfig.contentInsets = .init(top: 5, leading: 12, bottom: 5, trailing: 12)
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.image = UIImage(systemName: "chevron.down", withConfiguration: imageConfig)
        buttonConfig.imagePadding = 4
        buttonConfig.imagePlacement = .trailing
        $0.configuration = buttonConfig
        
//        $0.setAttributedTitle(NSAttributedString(string: "asdf", attributes: [.font: captionText02!, .foregroundColor: gray07!]), for: .normal)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.masksToBounds = true
        
        // menu 설정
        $0.menu = UIMenu(children: 
                            filterList?.map { element in
            return UIAction(title: element, handler: { action in
                print(action.title)
            })
        } ??
                            [
            UIAction(title: "인기순11", state: .on, handler: { action in
                print("인기순")
            }),
            UIAction(title: "리뷰순11", handler: { action in
                print("리뷰순")
            }),
            UIAction(title: "평점순11", handler: { action in
                print("평점순")
            }),
                            ]
        )
        
        $0.showsMenuAsPrimaryAction = true
        $0.changesSelectionAsPrimaryAction = true

    }
    
    private lazy var infoButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
        $0.tintColor = .gray05
        
        // menu 설정
        $0.menu = UIMenu(children: [
            UIAction(title: infoText ?? "", handler: {_ in} )
        ])
        
        $0.showsMenuAsPrimaryAction = true
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
        // MARK: Input
        let input = MainPageCollectionHeaderViewModel.Input(
            filterSelectEvent: filterSelectEvent,
            selectedCategory: selectedCategory)
        
        // MARK: Output
        let output = viewModel.transform(input: input)
        
        // MainPageViewModel로 전달되는 filterSelectEvent 연결
//        output.selectedFilter
//            .bind(to: filterSelectEvent)
//            .disposed(by: disposeBag)
        
        // MainPageViewModel에서 전달된 Category에 따라 filter 목록 변경
        output.filters
            .bind(onNext: { [weak self] filters in
                self?.filterButton.menu = UIMenu(children: filters.map { filter in
                    return UIAction(title: filter.inKorean, handler: { action in
                        self?.filterSelectEvent.onNext(filter)
                        print(action.title)
                    })
                })
            })
            .disposed(by: disposeBag)
        
        // MainPageViewModel에서 전달된 Category에 따라 소개 문구 변경
        output.infoText
            .bind(onNext: { [weak self] infoComment in
                self?.infoButton.menu = UIMenu(children: [UIAction(title: infoComment, handler: { _ in})])
            })
            .disposed(by: disposeBag)

    }
    
    private func setUpLayout() {
        [
            filterButton,
            infoButton
        ].forEach { self.addSubview($0) }
    }
    
    private func setUpConstraint() {
        filterButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        infoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(selectedCategory: PublishSubject<Category>, filterSelectEvent: PublishSubject<CombinedSearchFilter>) {
        
        self.selectedCategory = selectedCategory
        self.filterSelectEvent = filterSelectEvent
        
//        var filterArray:[String] = []
//        
//        switch category {
//        case .BookStore:
//            filters.allCases.forEach {
//                filterArray.append($0.inKorean)
//            }
//        case .BookClub:
//            BookClubSearchFilter.allCases.forEach {
//                filterArray.append($0.inKorean)
//            }
//        case .Publication:
//            PublicationSearchFilter.allCases.forEach {
//                filterArray.append($0.inKorean)
//            }
//        }
//        
//        filterList = filterArray
//        infoText = category.infoComment
    }
    
    private func refreshFilter() {
        self.filterButton.menu = UIMenu(children: filterList?.map { element in
            return UIAction(title: element, handler: { action in
                print(action.title)
            })
        } ?? [UIAction(title: "", handler: { _ in} )] )
    }
    
    private func refreshInfoText() {
        self.infoButton.menu = UIMenu(children: [
            UIAction(title: infoText ?? "", handler: { _ in} )
        ])
    }
    
}

@available(iOS 17.0, *)
#Preview {
    MainPageCollectionHeaderView()
}

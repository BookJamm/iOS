//
//  MainPageCollectionHeaderView.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

import UIKit
import SnapKit
import Then

final class MainPageCollectionHeaderView: UICollectionReusableView {
    
    // MARK: Variables
    static let id = "MainPageCollectionHeaderView"
    
    var filterList: [String]?
    var infoText: String?
    
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
        
        [
            filterButton,
            infoButton
        ].forEach { self.addSubview($0) }
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: Category) {
        switch category {
        case .BookStore:
            filters.allCases.forEach {
                self.filterList?.append($0.inKorean)
            }
        case .BookClub:
            BookClubSearchFilter.allCases.forEach {
                self.filterList?.append($0.inKorean)
            }
        case .Pulication:
            PublicationSearchFilter.allCases.forEach {
                self.filterList?.append($0.inKorean)
            }
        }
        infoText = category.infoComment
    }
}

@available(iOS 17.0, *)
#Preview {
    MainPageCollectionHeaderView()
}

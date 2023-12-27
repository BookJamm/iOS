//
//  MainPageTopView.swift
//  BookJam
//
//  Created by 박민서 on 12/24/23.
//

import UIKit
import Then
import SnapKit

final class MainPageTopView: UICollectionViewCell {
    
    // MARK: Variables
    
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
    lazy var publicationButton = CategoryButton(category: .Pulication)
    
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

        [
            searchBar,
            borderLine,
            categoryStackView
        ].forEach { self.addSubview($0)}
        
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
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    MainPageTopView()
}

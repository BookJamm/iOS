//
//  SearchPageSearchBar.swift
//  BookJam
//
//  Created by 박민서 on 2/5/24.
//

import UIKit
import SnapKit

class SearchPageSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setup
        self.tintColor = .main02
        self.backgroundImage = UIImage(color: .gray01, size: .init(width: 10, height: 10))
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        
            
        // image
        self.setImage(.search, for: .search, state: .normal)
        
        // searchTextField
        self.searchTextField.backgroundColor = .clear
        self.searchTextField.attributedPlaceholder = .init(
            string: "상호명 또는 주소 검색",
            attributes: [.font: paragraph02!, .foregroundColor: UIColor.gray06])
        self.searchTextField.attributedText = .init(
            string: "",
            attributes: [.font: paragraph02!, .foregroundColor: UIColor.gray06])
        self.searchTextField.font = paragraph02
        self.searchTextField.textColor = gray06
        
        // textField SNP
        self.searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0,*)
#Preview {
    SearchPageSearchBar(frame: CGRect(x: 0, y: 0, width: 350, height: 44))
}

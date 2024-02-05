//
//  SearchPageContentHeaderView.swift
//  BookJam
//
//  Created by 박민서 on 2/5/24.
//

import UIKit
import SnapKit
import Then
import RxSwift


class SearchPageResultCountView: UICollectionReusableView {
    
    // MARK: Variables
    static let id = "SearchPageCollecionHeaderView"
    
    // Rx - DisposeBag
    let disposeBag = DisposeBag()
    
    // Rx - ViewModel
    var viewModel: MainPageCollectionHeaderViewModel? {
        didSet {
            setUpBinding()
        }
    }
    
    private var resultLabel:UILabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
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

    }
    
    private func setUpLayout() {
        [
            resultLabel
        ].forEach { self.addSubview($0) }
    }
    
    private func setUpConstraint() {
        resultLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func applyConfigWithString(target:String, count:Int) {
        
        let resultString = "\(target) 검색결과 \(count)"

        let attributedString = NSMutableAttributedString(string: resultString)

        let range1 = NSRange(location: 0, length: target.count + 6)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range1)

        let range2 = NSRange(location: target.count + 6, length: String(count).count)
        attributedString.addAttribute(.foregroundColor, value: UIColor.main03, range: range2)
        
        attributedString.addAttribute(.font, value: paragraph04!, range: .init(location: 0, length: resultString.count))

        resultLabel.attributedText = attributedString
    }
}

@available(iOS 17.0, *)
#Preview {
    SearchPageResultCountView()
}

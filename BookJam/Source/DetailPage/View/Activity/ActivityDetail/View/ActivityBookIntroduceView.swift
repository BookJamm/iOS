//
//  ActivityBookIntroduceView.swift
//  BookJam
//
//  Created by 장준모 on 2/13/24.
//

import UIKit

class ActivityBookIntroduceView: UIView {

    // MARK: Variables
    
    static let id = "activityBookIntroduceView"
    
    let activityTitleLabel: UILabel = UILabel().then{
        $0.font = title03
        $0.textColor = .black
        $0.text = "모임 소개"
        $0.sizeToFit()
    }
    
    var activityContentsLabel: UILabel = UILabel().then{
        $0.font = paragraph01
        $0.numberOfLines = 3
        $0.textColor = gray09
        $0.sizeToFit()
        $0.text = "모임에 대한 소개글 입니다.모임에 대한 소개글 입니다.모임에 대한 소개글 입니다.모임에 대한 소개글 입니다.모임에 대한 소개글 입니다."
    }
    
    
    var activityImageView: UIImageView = UIImageView().then{
        $0.image = .squareDefault
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityImageView,
            activityTitleLabel,
            activityContentsLabel,
        ].forEach{ self.addSubview($0)}
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(18.5)
            $0.leading.equalToSuperview().offset(20)
        }
        activityContentsLabel.snp.makeConstraints{
            $0.top.equalTo(activityTitleLabel.snp.bottom).offset(34.5)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.leading.equalTo(activityTitleLabel)
        }
        activityImageView.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(activityContentsLabel.snp.bottom).offset(16)
            $0.height.equalTo(272)
        }
    }
    
    // MARK: Function


}

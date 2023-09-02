//
//  ActivityParticipateMoreTableViewCell.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/01.
//

import UIKit
import SwiftUI

class ActivityParticipateMoreTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    
    //셀 간 간격 두기
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Variables
    
    var cellID = "activityTableCell"

    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var activityNameLabel: UILabel = UILabel().then{
        $0.text = "행복마실 어르신 책놀이"
        $0.textColor = main03
        $0.font = paragraph01
        $0.sizeToFit()
    }
    
    var activityPeriodLabel: UILabel = UILabel().then {
        $0.font = paragraph04
        $0.text = "활동 기간"
        $0.sizeToFit()
    }
    
    var activityDayLabel:UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "2023. 08. 08 - 2023. 08.09"
        $0.sizeToFit()
    }
    
    var detailViewButton: UIButton = UIButton().then{
        $0.setTitle("자세히 보기", for: .normal)
        $0.titleLabel?.font = paragraph04
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = UIColor.clear
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityImageView,
            activityNameLabel,
            activityPeriodLabel,
            activityDayLabel,
            detailViewButton
        ].forEach{ self.contentView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.height.equalTo(100)
        }
        activityNameLabel.snp.makeConstraints{
            $0.top.equalTo(activityImageView).offset(10)
            $0.leading.equalTo(activityImageView.snp.trailing).offset(15)
            $0.height.equalTo(24)
        }
        activityPeriodLabel.snp.makeConstraints{
            $0.leading.equalTo(activityNameLabel)
            $0.top.equalTo(activityNameLabel.snp.bottom).offset(5)
            
        }
        activityDayLabel.snp.makeConstraints{
            $0.top.equalTo(activityPeriodLabel.snp.bottom).offset(5)
            $0.leading.equalTo(activityPeriodLabel)
        }
        
        detailViewButton.snp.makeConstraints{
            $0.top.equalTo(activityDayLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(activityImageView.snp.bottom)
            $0.leading.equalTo(activityDayLabel)
            $0.trailing.equalToSuperview().offset(-20).priority(.high)
            $0.height.equalTo(40)
        }
        
    }
}


#if DEBUG

@available(iOS 13.0, *)
struct ActivityParticipateMoreTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ActivityParticipateMoreTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

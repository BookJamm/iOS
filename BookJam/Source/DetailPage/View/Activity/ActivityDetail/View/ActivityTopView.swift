//
//  ActivityTopView.swift
//  BookJam
//
//  Created by 장준모 on 2/12/24.
//

import UIKit

final class ActivityTopView: UIView {

    // MARK: Variables
    
    static let id = "activityTopView"
    
    var photoImageView: UIImageView = UIImageView().then {
        $0.image = .defaultBook
        $0.clipsToBounds = true
    }
    
    var contentView: UIView = UIView().then{
        $0.backgroundColor = .white
        // 상단 그림자 효과
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(rect: $0.bounds).cgPath
        shadowLayer.fillColor = $0.backgroundColor?.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: -3.0) // 상단 그림자
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 5
        
        $0.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    var ifDeadLineButton: UIButton = UIButton().then {
        $0.setTitle("마감 임박", for: .normal)
        $0.contentVerticalAlignment = .center
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 5
        $0.backgroundColor = main03
    }
    
    var activityTypeButton: UIButton = UIButton().then {
        $0.setTitle("글쓰기", for: .normal)
        $0.contentVerticalAlignment = .center
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 5
        $0.backgroundColor = main05
    }

    var activityDayLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "첫 모임 11월 29일(수) 16:00"
        $0.sizeToFit()
    }
    
    var activityWeekLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "매주 목요일 3주간 진행"
        $0.sizeToFit()
    }
    
    var line: UIView = UIView().then{
        $0.backgroundColor = gray03
    }
    
    var activityTitleLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "여행하는 독서모임"
        $0.sizeToFit()
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "pin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "책발전소 광교"
        $0.sizeToFit()
    }
    
    var peopleImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "person.2.fill")
        $0.tintColor = gray05
        $0.contentMode = .scaleAspectFit
    }
    
    var numberOfPeopleLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "1/15"
        $0.sizeToFit()
    }
    var line2: UIView = UIView().then{
        $0.backgroundColor = gray03
    }
    var typeLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "선착순"
        $0.sizeToFit()
    }
    
    let priceImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "book.pages.fill")
        $0.tintColor = gray05
        $0.contentMode = .scaleAspectFit
    }
    
    var priceLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "12,000원"
        $0.sizeToFit()
    }
    
    // MARK: viewDidLoad()
    
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
        self.backgroundColor = gray01
    }
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            photoImageView,
            contentView
        ].forEach{ self.addSubview($0) }
        
        [
            ifDeadLineButton,
            activityDayLabel,
            activityWeekLabel,
            activityTitleLabel,
            activityTypeButton,
            line,
            line2,
            locationLabel,
            locationPinImageView,
            peopleImageView,
            numberOfPeopleLabel,
            typeLabel,
            priceLabel,
            priceImageView
        ].forEach{ contentView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        photoImageView.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(390)
        }
        contentView.snp.makeConstraints{
            $0.height.equalTo(241)
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(photoImageView.snp.bottom)
        }
        ifDeadLineButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(12)
            $0.width.equalTo(69)
            $0.height.equalTo(25)
        }
        activityTypeButton.snp.makeConstraints{
            $0.leading.equalTo(ifDeadLineButton.snp.trailing).offset(8)
            $0.top.equalTo(ifDeadLineButton)
            $0.width.equalTo(53)
            $0.height.equalTo(25)
        }
        activityDayLabel.snp.makeConstraints{
            $0.leading.equalTo(ifDeadLineButton)
            $0.top.equalTo(ifDeadLineButton.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(20)
        }
        activityWeekLabel.snp.makeConstraints{
            $0.leading.equalTo(activityDayLabel)
            $0.top.equalTo(activityDayLabel.snp.bottom).offset(2)
        }
        line.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(activityWeekLabel.snp.bottom).offset(12)
            $0.height.equalTo(0.34)
        }
        activityTitleLabel.snp.makeConstraints{
            $0.top.equalTo(line).offset(8)
            $0.horizontalEdges.equalToSuperview().offset(20)
        }
        locationPinImageView.snp.makeConstraints{
            $0.leading.equalTo(activityTitleLabel)
            $0.top.equalTo(activityTitleLabel.snp.bottom).offset(6.5)
            $0.size.equalTo(20)
        }
        locationLabel.snp.makeConstraints{
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(6)
            $0.top.equalTo(locationPinImageView)
        }
        peopleImageView.snp.makeConstraints{
            $0.leading.equalTo(locationPinImageView)
            $0.top.equalTo(locationPinImageView.snp.bottom).offset(6)
            $0.size.equalTo(20)
        }
        numberOfPeopleLabel.snp.makeConstraints{
            $0.leading.equalTo(peopleImageView.snp.trailing).offset(6)
            $0.top.equalTo(peopleImageView)
        }
        line2.snp.makeConstraints{
            $0.height.equalTo(8)
            $0.width.equalTo(0.7)
            $0.centerY.equalTo(numberOfPeopleLabel)
            $0.leading.equalTo(numberOfPeopleLabel.snp.trailing).offset(6.5)
        }
        typeLabel.snp.makeConstraints{
            $0.leading.equalTo(line2.snp.trailing).offset(6.5)
            $0.top.equalTo(numberOfPeopleLabel)
        }
        priceImageView.snp.makeConstraints{
            $0.leading.equalTo(peopleImageView)
            $0.top.equalTo(peopleImageView.snp.bottom).offset(6)
            $0.size.equalTo(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        priceLabel.snp.makeConstraints{
            $0.leading.equalTo(priceImageView.snp.trailing).offset(6)
            $0.top.equalTo(priceImageView)
        }
    }
    
    // MARK: Function


}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ActivityTopView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = ActivityTopView()
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

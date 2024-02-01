//
//  MainDetailActivityTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/10/23.
//

import UIKit

class MainDetailActivityTableViewCell: UITableViewCell {

    static let id =  "HomeActivityTabCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "defaultBook")
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = title03
        $0.text = "여행하는 독서모임"
        $0.sizeToFit()
    }
    
    var dateLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.text = "11월 29일(수) 16:00"
        $0.sizeToFit()
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }

    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "책발전소 광교"
        $0.sizeToFit()
    }
    
    var activityTypeButton: UIButton = UIButton().then {
        $0.setTitle("    글쓰기    ", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = captionText01
        $0.layer.cornerRadius = 14
        $0.backgroundColor = main05
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    // MARK: View
    
    func setUpView() {
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            bookImageView,
            titleLabel,
            dateLabel,
            locationPinImageView,
            locationLabel,
            activityTypeButton
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints{
            $0.width.height.equalTo(120)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(bookImageView.snp.trailing).offset(12)
            $0.top.equalTo(bookImageView)
        }
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        locationPinImageView.snp.makeConstraints{
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(locationPinImageView)
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(4)
        }
        activityTypeButton.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    public func configure(url: String, title: String,date: String, location: String) {
        bookImageView.kf.setImage(with: URL(string: url))
        titleLabel.text = title
        dateLabel.text = date
        locationLabel.text = location
    }

}

#if DEBUG
import SwiftUI

@available(iOS 16.0, *)
struct MainDetailActivityTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MainDetailActivityTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif

//
//  BookClubCollectionViewCell.swift
//  BookJam
//
//  Created by 박민서 on 1/19/24.
//
// -----------추후 병합이 필요합니다-------------
//
//  MainDetailActivityTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/10/23.
//

import UIKit

class BookClubCollectionViewCell: UICollectionViewCell {
    
    // MARK: Cell Model
    var cellModel: BookClub? {
        didSet {
            fetchCellData()
        }
    }

    static let id =  "BookClubCollectionViewCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "squareDefaultImage")
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
        $0.image = UIImage(named: "pin")
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
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setUpView()
//        setUpLayout()
//        setUpConstraint()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fetchCellData()
    }
    
    // MARK: View
    
    func setUpView() {
        self.backgroundColor = .white
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
    
    public func configure(title: String, content: String) {

    }
    
    // MARK: - Cell Model Data Fetching
    /// Cell Model의 데이터를 UI에 반영합니다
    private func fetchCellData() {
//        self.bookstoreLabel.text = self.cellModel?.name ?? "이름 없음"
//        self.locationLabel.text = self.cellModel?.address?.road ?? "주소 없음"
//        self.changeOpenStatus(isOpen: self.cellModel?.open)
//        self.changeStarStatus(rating: self.cellModel?.rating)
//        self.starLabel.text = self.cellModel?.rating?.description ?? "0.0"
//        self.reviewCountLabel.text =  "리뷰 " + (self.cellModel?.reviewCount?.description ?? "0")
//        self.images = self.cellModel?.images ?? []
        
        self.bookImageView.image = UIImage.book // 아래 내용 + kingFisher로 교체해야합니다.
//        self.bookImageView.image = self.cellModel?.cover
        self.titleLabel.text = self.cellModel?.name ?? "모임 이름 없음"
        self.dateLabel.text = self.cellModel?.date?.description ?? "날짜 없음"
        self.locationLabel.text = self.cellModel?.place ?? "장소 없음"
//        self.activityTypeButton.titleLabel?.text = self.cellModel?.type ?? "유형 없음"
        self.activityTypeButton.setTitle(self.cellModel?.type ?? "유형 없음", for: .normal)
    }

}

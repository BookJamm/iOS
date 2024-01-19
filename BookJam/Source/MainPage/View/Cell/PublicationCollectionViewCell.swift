//
//  PublicationCollectionViewCell.swift
//  BookJam
//
//  Created by 박민서 on 1/19/24.
//
// -----------추후 병합이 필요합니다-------------
//
//  MainDetailBookListTableViewCell.swift
//  BookJam
//
//  Created by 장준모 on 12/22/23.
//

import UIKit


class PublicationCollectionViewCell: UICollectionViewCell {
    
    // MARK: Cell Model
    var cellModel: Book? {
        didSet {
            fetchCellData()
        }
    }

    static let id =  "PublicationCollectionViewCell"
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "emptyBook")
    }
    
    var locationLabel: UILabel = UILabel().then{
        $0.font = paragraph06
        $0.text = "책발전소 광교"
        $0.textColor  = gray06
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = gray07
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
        $0.text = "우리는 중독을 사랑해"
    }
    
    var bookCategoryButton: UIButton = UIButton().then {
        $0.setTitle("인문학", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.titleLabel?.font = captionText02
        $0.layer.cornerRadius = 14
        
        $0.backgroundColor = gray01
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "도우리"
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = gray06
        $0.text = "한겨레 출판사"
    }
    
    var priceLabel: UILabel = UILabel().then{
        $0.text = "10,000원"
        $0.font = paragraph03
        $0.textColor = gray09
    }
    
    var line: UIView = UIView().then{
        $0.backgroundColor = gray03
    }
    
    var line2: UIView = UIView().then{
        $0.backgroundColor = gray03
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
            locationLabel,
            locationPinImageView,
            titleLabel,
            bookCategoryButton,
            authorLabel,
            publisherLabel,
            priceLabel,
            line,
            line2
        ].forEach { self.addSubview($0) }
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        bookImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(12)
        }
        
        locationPinImageView.snp.makeConstraints{
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(12)
        }
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(locationPinImageView)
            $0.leading.equalTo(locationPinImageView.snp.trailing).offset(4)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(locationPinImageView)
        }
        bookCategoryButton.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(locationPinImageView)
        }
        line.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(8)
            $0.leading.equalTo(bookCategoryButton.snp.trailing).offset(8)
            $0.centerY.equalTo(bookCategoryButton)
        }
        authorLabel.snp.makeConstraints{
            $0.leading.equalTo(line.snp.trailing).offset(8)
            $0.centerY.equalTo(line)
        }
        line2.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(8)
            $0.centerY.equalTo(line)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(8)
        }
        publisherLabel.snp.makeConstraints{
            $0.centerY.equalTo(line)
            $0.leading.equalTo(line2.snp.trailing).offset(8)
        }
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(publisherLabel.snp.bottom).offset(4)
            $0.leading.equalTo(bookCategoryButton)
        }
    }
    
//    public func configure(title: String, content: String) {
//        newsLabel.text = title
//        newsContent.text = content
//    }
    
    // MARK: - Cell Model Data Fetching
    /// Cell Model의 데이터를 UI에 반영합니다
    private func fetchCellData() {
        self.bookImageView.image = UIImage.book // 아래 내용 + kingFisher로 교체해야합니다.
//        self.bookImageView.image = self.cellModel?.cover
        self.locationLabel.text = self.cellModel?.place ?? "장소 없음"
        self.titleLabel.text = self.cellModel?.title ?? "제목 없음"
        self.bookCategoryButton.setTitle(self.cellModel?.genre ?? "장르 없음", for: .normal)
        self.authorLabel.text = self.cellModel?.author ?? "작가 미상"
        self.publisherLabel.text = self.cellModel?.publisher ?? "출판사 미상"
        self.priceLabel.text = self.cellModel?.price ?? "가격 없음"
    }
}

@available(iOS 17.0, *)
#Preview {
    PublicationCollectionViewCell()
}

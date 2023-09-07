//
//  RecordMoreDetailVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/03.
//

import UIKit
import SwiftUI

class RecordMoreDetailVC: UIViewController{

    // MARK: Variables
    
    var scrollView: UIScrollView = UIScrollView().then {
        $0.backgroundColor = gray02
    }
    
    var contentView: UIView = UIView()
    
    //최상단 기록 뷰
    var recordMainView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var visitDayButton: UIButton = UIButton().then{
        $0.setTitle("2023 / 07 / 12", for: .normal)
        $0.backgroundColor = main05
        $0.setTitleColor(main03, for: .normal)
        
        let borderColor = UIColor(red: 1.0, green: 0.8706, blue: 0.6745, alpha: 1.0) // FFDEAC color
        $0.layer.borderColor = borderColor.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(didSelectDateButtonTapped), for: .touchUpInside)
    }
    /// 방문 날짜 업데이트를 위한 날짜 표시 포맷 선언
    let dateFormat = DateFormatter().then {
        $0.dateFormat = "yyyy / MM / dd"
        $0.locale = Locale(identifier:"ko_KR")
    }
    
    var visitDayRecordLabel: UILabel = UILabel().then{
        $0.text = "8월 8일의 기록"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var imageScrollView: UIScrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true
    }

    var imageStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    var recordTitleLabel: UILabel = UILabel().then{
        $0.text = "유저 기록 텍스트입니다."
        $0.sizeToFit()
    }
    
    var recordContentLabel: UILabel = UILabel().then{
        $0.text = "오늘은 괜히 꿀꿀한 날이었고, 때와 다름없이 책발전소 광교에 향했다.  우리는 중독을 사랑해라는 책을 읽었는데, 00부분과 00부분에서 감명을 받았다."
        $0.sizeToFit()
        $0.numberOfLines = 3
    }
    
    //방문 장소 뷰
    var visitPlaceView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var visitPlaceLabel: UILabel = UILabel().then{
        $0.text = "방문 장소"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "squareDefaultImage")
    }
    
    var visitDayLabel: UILabel = UILabel().then{
        $0.text = "2023 / 06/ 06 방문"
        $0.textColor = main03
        $0.font = captionText01
        $0.sizeToFit()
    }
    
    var bookStoreNameLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책발전소광교"
        $0.sizeToFit()
    }

    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var speechBubbleImageView : UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "bubble.left")
        $0.tintColor = .black
    }

    var speechBubbleLabel: UILabel = UILabel().then{
        $0.text = "213"
    }
    
    var heartImageView : UIImageView = UIImageView().then{
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .black
    }
    
    var heartLabel: UILabel = UILabel().then{
        $0.text = "213"
    }
    
    //이 순간 내가 읽은 책 뷰
    
    var readBookView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var readBookLabel: UILabel = UILabel().then{
        $0.text = "이 순간 내가 읽은 책"
        $0.font = title06
        $0.sizeToFit()
    }
    
    var bookImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "tempBookImage")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    var bookNameLabel: UILabel = UILabel().then {
        $0.text = "책 이름"
        $0.font = paragraph02
        $0.numberOfLines = 2
    }
    
    var authorLabel: UILabel = UILabel().then {
        $0.text = "작가 이름"
        $0.font = captionText02
        $0.textColor = gray06
        $0.numberOfLines = 3
    }
    
    var publisherLabel: UILabel = UILabel().then {
        $0.text = "출판사 이름"
        $0.font = captionText02
        $0.textColor = gray06
    }
    
    //활동한 내용 뷰
    var activityView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    var activityTitleLabal: UILabel = UILabel().then{
        $0.text = "활동한 내용"
        $0.font = title06
        $0.sizeToFit()
    }
    var activityTableView: UITableView = UITableView().then{
        $0.register(ActivityParticipateMoreTableViewCell.self, forCellReuseIdentifier: ActivityParticipateMoreTableViewCell().cellID)
    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
        setRecordImage()
        setUpNotification()
        
        activityTableView.separatorStyle = .none
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            recordMainView,//기록 뷰
            visitPlaceView,//방문 장소 뷰
            readBookView,//이 순간 내가 읽은 책 뷰
            activityView
        ].forEach{ contentView.addSubview($0)}
        
        [//최상단 기록 뷰
            visitDayButton,
            visitDayRecordLabel,
            imageScrollView,
            recordTitleLabel,
            recordContentLabel,
        ].forEach{ recordMainView.addSubview($0)}
        
        imageScrollView.addSubview(imageStackView)
        
        [//방문 장소 뷰
            visitPlaceLabel,
            activityImageView,
            visitDayLabel,
            bookStoreNameLabel,
            bookMarkImageView,
            speechBubbleImageView,
            speechBubbleLabel,
            heartImageView,
            heartLabel,
        ].forEach{ visitPlaceView.addSubview($0) }
        
        [//이 순간 내가 읽은 책 뷰
            readBookLabel,
            bookImageView,
            bookNameLabel,
            authorLabel,
            publisherLabel,
        ].forEach{ readBookView.addSubview($0)}
        
        [//활동한 내용 뷰
            activityTitleLabal,
            activityTableView
        
        ].forEach{ activityView.addSubview($0)}
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1300)
        }
        
        //최상단 기록 뷰
        recordMainView.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(630)
        }
        visitDayButton.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.equalTo(240)
            $0.height.equalTo(45)
        }
        visitDayRecordLabel.snp.makeConstraints{
            $0.top.equalTo(visitDayButton.snp.bottom).offset(10)
            $0.leading.equalTo(visitDayButton)
        }
        imageScrollView.snp.makeConstraints{
            $0.top.equalTo(visitDayRecordLabel.snp.bottom).offset(10)
            $0.height.equalTo(350)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview()
            
        }
        imageStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(imageScrollView.snp.height)
            $0.width.equalTo(contentView.snp.width).multipliedBy(2.8)
        }
        recordTitleLabel.snp.makeConstraints{
            $0.top.equalTo(imageStackView.snp.bottom).offset(20)
            $0.leading.equalTo(visitDayRecordLabel).offset(10)
        }
        recordContentLabel.snp.makeConstraints{
            $0.top.equalTo(recordTitleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(recordTitleLabel)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        //방문 장소 뷰
        visitPlaceView.snp.makeConstraints{
            $0.top.equalTo(recordMainView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(200)
        }
        visitPlaceLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(visitDayRecordLabel)
        }
        activityImageView.snp.makeConstraints{
            $0.top.equalTo(visitPlaceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(visitPlaceLabel)
            $0.width.height.equalTo(120)
        }
        visitDayLabel.snp.makeConstraints{
            $0.top.equalTo(activityImageView)
            $0.leading.equalTo(activityImageView.snp.trailing).offset(10)
        }
        bookStoreNameLabel.snp.makeConstraints{
            $0.top.equalTo(visitDayLabel.snp.bottom).offset(10)
            $0.leading.equalTo(visitDayLabel)
        }
        bookMarkImageView.snp.makeConstraints{
            $0.centerY.equalTo(bookStoreNameLabel)
            $0.leading.equalTo(bookStoreNameLabel.snp.trailing).offset(5)
        }
        speechBubbleImageView.snp.makeConstraints{
            $0.top.equalTo(bookStoreNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreNameLabel)
        }
        speechBubbleLabel.snp.makeConstraints{
            $0.centerY.equalTo(speechBubbleImageView)
            $0.leading.equalTo(speechBubbleImageView.snp.trailing).offset(5)
        }
        heartImageView.snp.makeConstraints{
            $0.leading.equalTo(speechBubbleLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(speechBubbleImageView)
        }
        heartLabel.snp.makeConstraints{
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(heartImageView)
        }
        
        //이 순간 내가 읽은 책 뷰
        readBookView.snp.makeConstraints{
            $0.top.equalTo(visitPlaceView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(190)
        }
        readBookLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(visitPlaceLabel)
        }
        bookImageView.snp.makeConstraints{
            $0.top.equalTo(readBookLabel.snp.bottom).offset(10)
            $0.height.equalTo(110)
            $0.leading.equalToSuperview().offset(10)
        }
        bookNameLabel.snp.makeConstraints{
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(10)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookNameLabel)
        }
        publisherLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(5)
        }
        
        //활동한 내용 뷰
        activityView.snp.makeConstraints{
            $0.top.equalTo(readBookView.snp.bottom).offset(10)
            $0.height.equalTo(230)
            $0.horizontalEdges.equalToSuperview()
        }
        activityTitleLabal.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(readBookLabel)
        }
        activityTableView.snp.makeConstraints{
            $0.top.equalTo(activityTitleLabal.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Notification
    
    func setUpNotification() {
        ///  SelectVisitDatePopUpVC에서 날짜 선택 마쳤을 때 버튼 날짜 업데이트를 위한 notification 수신
        NotificationCenter.default.addObserver(self, selector: #selector(visitDateUpdate(_:)), name: NSNotification.Name("feedVisitDateButtonTapped"), object: nil)
    }
    
    // MARK: Function

    func setRecordImage(){
        
        let image1 = UIImageView(image: UIImage(named: "squareDefaultImage"))
        let image2 = UIImageView(image: UIImage(named: "squareDefaultImage"))
        let image3 = UIImageView(image: UIImage(named: "squareDefaultImage"))
        
        imageStackView.addArrangedSubview(image1)
        imageStackView.addArrangedSubview(image2)
        imageStackView.addArrangedSubview(image3)
        
    }
    
    /// 선택한 날짜 데이터 notification으로 받아와서 버튼 날짜 업데이트
    @objc func visitDateUpdate(_ notification: Notification) {
        print("방문 날짜 notification 수신")
        
        if let date = notification.object as? Date {
            visitDayButton.setTitle(dateFormat.string(from: date), for: .normal)
        }
    }

    /// 현재 날짜 적혀있는 버튼 눌렀을 때 발생되는 이벤트
    @objc func didSelectDateButtonTapped() {
        let selectVisitDatePopUpVC = SelectVisitDatePopUpVC()
        selectVisitDatePopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        selectVisitDatePopUpVC.modalTransitionStyle = .crossDissolve
        selectVisitDatePopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(selectVisitDatePopUpVC, animated: true)
    }
    
}//end of RecordMoreDetailVC


// MARK: Extension

extension RecordMoreDetailVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityParticipateMoreTableViewCell().cellID, for: indexPath) as! ActivityParticipateMoreTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//struct RecordMoreDetailVC_Preview: PreviewProvider {
//    static var previews: some View {
//        RecordMoreDetailVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}

//
//  FeedPostPageVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/15.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class FeedPostPageVC: UIViewController {
    
    // MARK: Variables
    
    /// 업로드 버튼 활성화를 위해 활동 선택 section에서 활동을 선택했는지 판별하는 변수 선언
    var isActivitySelected: Bool = false
    
    /// 업로드 버튼 활성화를 위해 장소 section에서 장소와 종류를 선택했는지 판별하는 변수 선언
    var isPlaceTypeSelected: Bool = false
    var isplaceSelected: Bool = false
    
    /// 업로드 버튼 활성화를 위해 날짜 section에서 방문 날짜를 선택했는지 판별하는 변수 선언
    var isVisitDateSelected: Bool = false
    
    /// 업로드 버튼 활성화를 위해 책 제목 section에서 책을 선택했는지 판별하는 변수 선언
    var isBookSelected: Bool = false
    
    /// 업로드 버튼 활성화를 위해 내용 section에서 내용을 채웠는지 판별하는 변수 선언
    var isContentFilled: Bool = false
    
    /// 장소 검색해 선택했을 때 전달되는 notification object를 통해 도로명 주소를 받아올 변수 선언
    var address: String = ""
    
    /// 방문 날짜 업데이트를 위한 날짜 표시 포맷 선언
    let dateFormat = DateFormatter().then {
        $0.dateFormat = "yyyy / MM / dd"
        $0.locale = Locale(identifier:"ko_KR")
    }
    
    /// 글 작성할 때 사진 추가하면 저장할 이미지 배열 선언
    var images: [UIImage] = []
    
    var customNavigationView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var scrollView: UIScrollView = UIScrollView()
    
    var contentView: UIView = UIView()
    
    var backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didPostCustomBackButtonTapped), for: .touchUpInside)
    }
    
    var postLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "글 작성"
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var photoView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var photoLabel: UILabel = UILabel().then {
        $0.text = "사진"
        $0.font = title06
    }
    
    var addPhotoButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.square.fill.on.square.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 40, weight: .regular, scale: .default)), for: .normal)
        $0.tintColor = gray07
        $0.backgroundColor = gray03
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didAddPostPhotoButtonTapped), for: .touchUpInside)
    }
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(VisitReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: VisitReviewPhotoCollectionViewCell.cellID)
    }
    
    var selectDateView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var selectDateLabel: UILabel = UILabel().then {
        $0.text = "방문 날짜"
        $0.font = title06
    }
    
    var selectDateInfoButton: UIButton = UIButton().then {
        $0.setTitle("날짜 선택", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.backgroundColor = main01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.7
        $0.layer.borderColor = main03?.cgColor
        $0.isEnabled = false
    }
    
    var selectDateButton: UIButton = UIButton().then {
        $0.setTitle("현재 날짜로 설정", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 0.7
        $0.addTarget(self, action: #selector(didSelectDateButtonTapped), for: .touchUpInside)
    }
    
    var activityView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var activityLabel: UILabel = UILabel().then {
        $0.text = "활동 선택"
        $0.font = title06
    }
    
    var activityInfoView: UIView = UIView().then {
        $0.backgroundColor = gray01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 0.7
    }
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
    }
    
    var activityInfoLabel: UILabel = UILabel().then {
        $0.text = "행복마실 어르신 책놀이"
        $0.font = paragraph01
        $0.textColor = main03
    }
    
    var activityStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var activityRatingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var activityNumOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var cancelButton: UIButton = UIButton().then {
        $0.setTitle("선택 취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = main01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = main03?.cgColor
        $0.layer.borderWidth = 0.7
    }
    
    var activitySelectButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "emptyActivity"), for: .normal)
        $0.addTarget(self, action: #selector(didActivitySelectButtonTapped), for: .touchUpInside)
    }
    
    var placeView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var placeLabel: UILabel = UILabel().then {
        $0.text = "장소"
        $0.font = title06
    }
    
    var bookStorebutton: UIButton = UIButton().then {
        $0.setTitle("독립서점", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didBookStoreButtonTapped), for: .touchUpInside)
    }
    
    var playGroundButton: UIButton = UIButton().then {
        $0.setTitle("책 놀이터", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didPlayGroundButtonTapped), for: .touchUpInside)
    }
    
    var libraryButton: UIButton = UIButton().then {
        $0.setTitle("도서관", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didLibraryButtonTapped), for: .touchUpInside)
    }
    
    var addressSearchView: UIView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = gray05?.cgColor
        $0.layer.borderWidth = 1
    }
    
    var addressSearchButton: UIButton = UIButton().then {
        $0.setTitle(" 상호명 또는 주소 검색", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = gray06
        $0.addTarget(self, action: #selector(didAddressSearchButtonTapped), for: .touchUpInside)
    }
    
    var bookStoreView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookStoreImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.contentMode = .scaleAspectFill
    }
    
    var bookStoreLabel: UILabel = UILabel().then {
        $0.text = "책방 이름"
        $0.font = title06
    }
    
    var bookStoreTypeImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var bookStoreAddressLabel: UILabel = UILabel().then {
        $0.text = "책방주소책방주소책방주소책방주소책방주소책방주소책방주소"
        $0.font = paragraph03
        $0.textColor = gray06
        $0.numberOfLines = 2
    }
    
    var bookStoreStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var bookStoreRatingLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.text = "5.00"
    }
    
    var bookStoreNumOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var bookView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookSearchLabel: UILabel = UILabel().then {
        $0.text = "책 제목"
        $0.font = title06
    }
    
    var bookSearchView: UIView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = gray05?.cgColor
        $0.layer.borderWidth = 1
    }
    
    var bookSearchButton: UIButton = UIButton().then {
        $0.setTitle(" 책 이름 검색", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = gray06
        $0.addTarget(self, action: #selector(didBookSearchButtonTapped), for: .touchUpInside)
    }
    
    var bookSearchResultImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "emptyBook")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    var bookSearchResultNameLabel: UILabel = UILabel().then {
        $0.text = "책이름"
        $0.font = paragraph02
    }
    
    var bookSearchResultAuthorLabel: UILabel = UILabel().then {
        $0.text = "작가"
        $0.font = captionText02
        $0.textColor = gray06
    }
    
    var bookSearchResultPublisherLabel: UILabel = UILabel().then {
        $0.text = "출판사"
        $0.font = captionText02
        $0.textColor = gray06
    }
    
    var reviewContentView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var reviewContentInfoLabel: UILabel = UILabel().then {
        $0.text = "내용"
        $0.font = title06
    }
    
    var reviewContentBackgroundView: UIView = UIView().then {
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 1
    }
    
    var reviewContentTextView: UITextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = paragraph01
        $0.textColor = gray05
        $0.text = "당신의 한마디를 입력해주세요."
    }
    
    var uploadView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var secretPostLabel: UILabel = UILabel().then {
        $0.text = "비공개로 게시하기"
        $0.font = paragraph02
    }
    
    var secretPostToggleButton: UISwitch = UISwitch().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var allowCommentLabel: UILabel = UILabel().then {
        $0.text = "댓글 비허용"
        $0.font = paragraph02
    }
    
    var allowCommentToggleButton: UISwitch = UISwitch().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var uploadButton: UIButton = UIButton().then {
        $0.setTitle("업로드", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = paragraph01
        $0.backgroundColor = gray04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didFeedUploadButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        setUpNotification()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = gray02
        hideKeyboard()
        
        /// 방문 날짜 현재 날짜로 설정
        let now = Date()
        selectDateButton.setTitle(dateFormat.string(from: now), for: .normal)
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            customNavigationView,
            scrollView
        ].forEach { view.addSubview($0) }
        
        [
            backButton,
            postLabel,
            underLineView
        ].forEach { customNavigationView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        [
            photoView,
            selectDateView,
            activityView,
            placeView,
            bookView,
            reviewContentView,
            uploadView
        ].forEach { contentView.addSubview($0) }
        
        [
            photoLabel,
            addPhotoButton,
            photoCollectionView
        ].forEach { photoView.addSubview($0) }
        
        [
            selectDateLabel,
            selectDateInfoButton,
            selectDateButton
        ].forEach { selectDateView.addSubview($0) }
        
        [
            activityLabel,
            activityInfoView,
            activitySelectButton
        ].forEach { activityView.addSubview($0) }
        
        [
            activityImageView,
            activityInfoLabel,
            activityStarImageView,
            activityRatingLabel,
            activityNumOfReviewLabel,
            cancelButton
        ].forEach { activityInfoView.addSubview($0) }
        
        [
            placeLabel,
            bookStorebutton,
            playGroundButton,
            libraryButton,
            addressSearchView,
            addressSearchButton,
            bookStoreView
        ].forEach { placeView.addSubview($0) }
        
        [
            bookStoreImageView,
            bookStoreLabel,
            bookStoreTypeImageView,
            bookStoreAddressLabel,
            bookStoreStarImageView,
            bookStoreRatingLabel,
            bookStoreNumOfReviewLabel
        ].forEach { bookStoreView.addSubview($0) }
        
        [
            bookSearchLabel,
            bookSearchView,
            bookSearchButton,
            bookSearchResultImageView,
            bookSearchResultNameLabel,
            bookSearchResultAuthorLabel,
            bookSearchResultPublisherLabel
        ].forEach { bookView.addSubview($0) }
        
        [
            reviewContentInfoLabel,
            reviewContentBackgroundView,
            reviewContentTextView
        ].forEach { reviewContentView.addSubview($0) }
       
        [
            secretPostLabel,
            secretPostToggleButton,
            allowCommentLabel,
            allowCommentToggleButton,
            uploadButton
        ].forEach { uploadView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        reviewContentTextView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        customNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        postLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.bottom.equalTo(uploadView.snp.bottom)
        }
        
        photoView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        addPhotoButton.snp.makeConstraints {
            $0.top.equalTo(photoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(photoLabel)
            $0.height.width.equalTo(140)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(addPhotoButton.snp.top)
            $0.leading.equalTo(addPhotoButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(addPhotoButton.snp.bottom)
        }
        
        selectDateView.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectDateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        selectDateInfoButton.snp.makeConstraints {
            $0.top.equalTo(selectDateLabel.snp.bottom).offset(20)
            $0.leading.equalTo(selectDateLabel)
            $0.width.equalTo(120)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        selectDateButton.snp.makeConstraints {
            $0.top.equalTo(selectDateInfoButton)
            $0.leading.equalTo(selectDateInfoButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(selectDateInfoButton.snp.bottom)
        }
        
        activityView.snp.makeConstraints {
            $0.top.equalTo(selectDateView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
//        /// 활동 선택됐으면 활동 정보 표시
//        if isActivitySelected == true {
//            activityInfoView.snp.makeConstraints {
//                $0.top.equalTo(activityLabel.snp.bottom).offset(20)
//                $0.leading.equalTo(activityLabel)
//                $0.trailing.equalToSuperview().offset(-20)
//                $0.height.equalTo(150)
//                $0.bottom.equalToSuperview().offset(-20)
//            }
//
//            activityImageView.snp.makeConstraints {
//                $0.top.leading.equalToSuperview().offset(12)
//                $0.width.height.equalTo(128)
//            }
//
//            activityInfoLabel.snp.makeConstraints {
//                $0.top.equalTo(activityImageView).offset(5)
//                $0.leading.equalTo(activityImageView.snp.trailing).offset(14)
//                $0.trailing.equalToSuperview().offset(-10)
//            }
//
//            activityStarImageView.snp.makeConstraints {
//                $0.top.equalTo(activityInfoLabel.snp.bottom).offset(10)
//                $0.leading.equalTo(activityInfoLabel)
//            }
//
//            activityRatingLabel.snp.makeConstraints {
//                $0.centerY.equalTo(activityStarImageView)
//                $0.leading.equalTo(activityStarImageView.snp.trailing).offset(5)
//            }
//
//            activityNumOfReviewLabel.snp.makeConstraints {
//                $0.centerY.equalTo(activityStarImageView)
//                $0.leading.equalTo(activityRatingLabel.snp.trailing).offset(5)
//            }
//
//            cancelButton.snp.makeConstraints {
//                $0.top.equalTo(activityStarImageView.snp.bottom).offset(25)
//                $0.leading.equalTo(activityStarImageView)
//                $0.trailing.equalToSuperview().offset(-10)
//                $0.bottom.equalTo(activityImageView.snp.bottom).offset(-5)
//            }
//        }
        activitySelectButton.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(20)
            $0.leading.equalTo(activityLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(activityView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        bookStorebutton.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(placeLabel)
            $0.width.equalTo(120)
            $0.height.equalTo(45)
        }
        
        playGroundButton.snp.makeConstraints {
            $0.top.bottom.equalTo(bookStorebutton)
            $0.leading.equalTo(bookStorebutton.snp.trailing).offset(5)
            $0.width.equalTo(bookStorebutton)
        }
        
        libraryButton.snp.makeConstraints {
            $0.top.bottom.equalTo(bookStorebutton)
            $0.leading.equalTo(playGroundButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(bookStorebutton)
        }
        
        addressSearchView.snp.makeConstraints {
            $0.top.equalTo(bookStorebutton.snp.bottom).offset(20)
            $0.leading.equalTo(bookStorebutton)
            $0.trailing.equalTo(libraryButton)
            $0.height.equalTo(45)
        }
        
        addressSearchButton.snp.makeConstraints {
            $0.centerY.equalTo(addressSearchView)
            $0.leading.equalTo(addressSearchView).offset(20)
        }
        
        addressSearchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        
        bookView.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        bookSearchLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        bookSearchView.snp.makeConstraints {
            $0.top.equalTo(bookSearchLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        bookSearchButton.snp.makeConstraints {
            $0.centerY.equalTo(bookSearchView.snp.centerY)
            $0.leading.equalTo(bookSearchView.snp.leading).offset(20)
        }
        
        bookSearchResultImageView.snp.makeConstraints {
            $0.top.equalTo(bookSearchView.snp.bottom).offset(20)
            $0.leading.equalTo(bookSearchView).offset(20)
            $0.width.equalTo(110)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        bookSearchResultNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookSearchResultImageView).offset(5)
            $0.leading.equalTo(bookSearchResultImageView.snp.trailing).offset(20)
        }
        
        bookSearchResultAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookSearchResultNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookSearchResultImageView.snp.trailing).offset(20)
        }
        
        bookSearchResultPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookSearchResultAuthorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookSearchResultImageView.snp.trailing).offset(20)
        }
        
        reviewContentView.snp.makeConstraints {
            $0.top.equalTo(bookView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        reviewContentInfoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }

        reviewContentBackgroundView.snp.makeConstraints {
            $0.top.equalTo(reviewContentInfoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(reviewContentInfoLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview().offset(-20)
        }

        reviewContentTextView.snp.makeConstraints {
            $0.top.equalTo(reviewContentBackgroundView).offset(20)
            $0.leading.equalTo(reviewContentBackgroundView).offset(20)
            $0.trailing.equalTo(reviewContentView).offset(-20)
            $0.bottom.equalTo(reviewContentBackgroundView.snp.bottom).offset(-20)
        }
        
        uploadView.snp.makeConstraints {
            $0.top.equalTo(reviewContentView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        secretPostLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        secretPostToggleButton.snp.makeConstraints {
            $0.centerY.equalTo(secretPostLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        allowCommentLabel.snp.makeConstraints {
            $0.top.equalTo(secretPostLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        allowCommentToggleButton.snp.makeConstraints {
            $0.centerY.equalTo(allowCommentLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        uploadButton.snp.makeConstraints {
            $0.top.equalTo(allowCommentLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    
    // MARK: Function
    
    /// 업로드 버튼 활성화 가능 여부 판단하는 함수
    /// 방문날짜, 장소, 책제목, 내용 모두 선택하고 채워야 업로드 함수 활성화
    func checkUploadPossible() {
        if isActivitySelected && isPlaceTypeSelected && isplaceSelected && isVisitDateSelected && isBookSelected && isContentFilled {
            uploadButton.backgroundColor = main03
            uploadButton.isEnabled = true
        }
        else {
            uploadButton.backgroundColor = gray03
            uploadButton.isEnabled = false
        }
    }
    
    /// 네비게이션 바에 있는 뒤로가기 버튼 누르면 현재 뷰 dismiss
    @objc func didPostCustomBackButtonTapped() {
        self.dismiss(animated: true)
    }
    
    /// 책 검색 버튼 누르면 팝업창 present
    @objc func didBookSearchButtonTapped() {
        let searchBookPopUpVC = SearchBookPopUpVC()
        
        searchBookPopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        searchBookPopUpVC.modalTransitionStyle = .crossDissolve
        searchBookPopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(searchBookPopUpVC, animated: true)
    }
    
    /// 활동 선택 버튼 누르면 팝업창 present
    @objc func didActivitySelectButtonTapped() {
        let searchActivityPopUpVC = SearchActivityPopUpVC()
        
        searchActivityPopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        searchActivityPopUpVC.modalTransitionStyle = .crossDissolve
        searchActivityPopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(searchActivityPopUpVC, animated: true)
    }
    
    /// 장소 탭 버튼 3개 선택된 버튼과 아닌 버튼 구분해서 색상 변경
    @objc func didBookStoreButtonTapped() {
        print("독립서점 선택됨")
        
        libraryButton.backgroundColor = gray02
        libraryButton.layer.borderColor = gray03?.cgColor
        libraryButton.isSelected = false
        
        playGroundButton.backgroundColor = gray02
        playGroundButton.layer.borderColor = gray03?.cgColor
        playGroundButton.isSelected = false
        
        bookStorebutton.isSelected = true
        bookStorebutton.backgroundColor = main01
        bookStorebutton.layer.borderColor = main03?.cgColor
        
        // 업로드 가능한지 판별
        isPlaceTypeSelected = true
        checkUploadPossible()
    }
    
    @objc func didPlayGroundButtonTapped() {
        print("책 놀이터 선택됨")
        
        bookStorebutton.backgroundColor = gray02
        bookStorebutton.layer.borderColor = gray03?.cgColor
        bookStorebutton.isSelected = false
        
        libraryButton.backgroundColor = gray02
        libraryButton.layer.borderColor = gray03?.cgColor
        libraryButton.isSelected = false
        
        playGroundButton.isSelected = true
        playGroundButton.backgroundColor = main01
        playGroundButton.layer.borderColor = main03?.cgColor
       
        
        // 업로드 가능한지 판별
        isPlaceTypeSelected = true
        checkUploadPossible()
    }
    
    @objc func didLibraryButtonTapped() {
        print("도서관 선택됨")
        
        bookStorebutton.backgroundColor = gray02
        bookStorebutton.setTitleColor(.gray, for: .normal)
        bookStorebutton.layer.borderColor = gray03?.cgColor
        bookStorebutton.isSelected = false
        
        playGroundButton.backgroundColor = gray02
        playGroundButton.layer.borderColor = gray03?.cgColor
        playGroundButton.isSelected = false
        
        libraryButton.isSelected = true
        libraryButton.backgroundColor = main01
        libraryButton.layer.borderColor = main03?.cgColor
        
        // 업로드 가능한지 판별
        isPlaceTypeSelected = true
        checkUploadPossible()
    }
    
    /// 장소 탭에 있는 검색 바 누르면 발생하는 이벤트
    @objc func didAddressSearchButtonTapped() {
        let searchPlacePopUpVC = SearchPlacePopUpVC()
        searchPlacePopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        searchPlacePopUpVC.modalTransitionStyle = .crossDissolve
        searchPlacePopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(searchPlacePopUpVC, animated: true)
    }
    
    /// 현재 날짜 적혀있는 버튼 눌렀을 때 발생되는 이벤트
    @objc func didSelectDateButtonTapped() {
        let selectVisitDatePopUpVC = SelectVisitDatePopUpVC()
        selectVisitDatePopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        selectVisitDatePopUpVC.modalTransitionStyle = .crossDissolve
        selectVisitDatePopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(selectVisitDatePopUpVC, animated: true)
    }
    
    /// 선택된 장소 도로명 주소 notification으로 받아와서 장소 탭 업데이트
    @objc func feedPostPageUpdate(_ notification: Notification) {
        print("장소 선택 notification 수신")
        
        /// 장소 정보 뷰 추가해줌
        bookStoreView.snp.makeConstraints {
            $0.top.equalTo(addressSearchView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(addressSearchView)
            $0.height.equalTo(120)
            $0.bottom.equalTo(placeView.snp.bottom).offset(-20)
        }
        
        bookStoreImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(bookStoreView.snp.height)
        }
        
        bookStoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalTo(bookStoreImageView.snp.trailing).offset(20)
        }
        
        bookStoreTypeImageView.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreLabel)
            $0.leading.equalTo(bookStoreLabel.snp.trailing).offset(5)
        }
        
        bookStoreAddressLabel.snp.makeConstraints {
            $0.top.equalTo(bookStoreLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreLabel)
            $0.trailing.equalToSuperview()
        }
        
        bookStoreStarImageView.snp.makeConstraints {
            $0.top.equalTo(bookStoreAddressLabel.snp.bottom).offset(10)
            $0.leading.equalTo(bookStoreAddressLabel)
        }
        
        bookStoreRatingLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreStarImageView)
            $0.leading.equalTo(bookStoreStarImageView.snp.trailing).offset(5)
        }
        
        bookStoreNumOfReviewLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookStoreStarImageView)
            $0.leading.equalTo(bookStoreRatingLabel.snp.trailing).offset(5)
        }
        
        /// 주소 notification으로 받아와서 장소 탭 주소 업데이트
        if let address = notification.object as? String {
            bookStoreAddressLabel.text = "\(address)"
        }
        
        // TODO: 받아온 주소 API 연결해서 장소 정보 업데이트
        
        // bookStoreImageView.image = UIImage()
        // bookStoreLabel.text = ""
        // bookStoreRatingLabel.text = ""
        // bookStoreNumOfReviewLabel.text = "리뷰 \()"
        
        /// 업로드 버튼 활성화 가능한지 체크
        isplaceSelected = true
        checkUploadPossible()
    }
    
    /// 선택한 날짜 데이터 notification으로 받아와서 버튼 날짜 업데이트
    @objc func visitDateUpdate(_ notification: Notification) {
        print("방문 날짜 notification 수신")
        
        if let date = notification.object as? Date {
            selectDateButton.setTitle(dateFormat.string(from: date), for: .normal)
        }
        
        /// 업로드 버튼 활성화 가능한지 체크
        isVisitDateSelected = true
        checkUploadPossible()
    }
    
    /// 작성 데이터 서버에 넘기고 화면 dismiss
    @objc func postData() {
        print("작성 완료 notification 수신")
        
        let content = reviewContentTextView.text
        var isSecret = 0
        var isCommentAllowed = 0
        var date = selectDateButton.titleLabel?.text?.replacingOccurrences(of: " / ", with: "-")
        
        if secretPostToggleButton.isOn { isSecret = 1 }
        if allowCommentToggleButton.isOn { isCommentAllowed = 1 }
        
        
        
        APIManager.shared.postData(
            urlEndpointString: Constant.postRecord,
            responseDataType: APIModel<RecordResponseModel>?.self,
            requestDataType: RecordRequestModel.self,
            parameter: RecordRequestModel(
                // TODO: userID랑 place 번호 어떻게 알아내는지 물어보기
                // TODO: 책 셀 구현하면 isbn API 연결해서 삽입
                userId: 0,
                place: 0,
                isbn: 0,
                date: date,
                emotions: 0,
                activity: 0,
                contents: content,
                isNotPublic: isSecret,
                commentNotAllowed: isCommentAllowed)) { response in
                    print(response)
                }
        
        self.dismiss(animated: true)
    }
    
    /// 업로드 버튼 누르면 정보 넘기고 화면 dismiss
    @objc func didFeedUploadButtonTapped() {
        let feedPostCheckPopUpVC = FeedPostCheckPopUpVC()
        
        feedPostCheckPopUpVC.view.backgroundColor = .black.withAlphaComponent(0.5)
        feedPostCheckPopUpVC.modalTransitionStyle = .crossDissolve
        feedPostCheckPopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(feedPostCheckPopUpVC, animated: true)
    }
    
    // MARK: Notification
    
    func setUpNotification() {
        /// SearchPlacePopUpVC에서 장소 선택 마쳤을 때 장소 탭 업데이트를 위한 notification 수신
        NotificationCenter.default.addObserver(self, selector: #selector(feedPostPageUpdate(_:)), name: NSNotification.Name("feedPlaceSearchResultCellTapped"), object: nil)
        
        ///  SelectVisitDatePopUpVC에서 날짜 선택 마쳤을 때 버튼 날짜 업데이트를 위한 notification 수신
        NotificationCenter.default.addObserver(self, selector: #selector(visitDateUpdate(_:)), name: NSNotification.Name("feedVisitDateButtonTapped"), object: nil)
        
        /// FeedPostPopUpVC에서 기록 작성을 완료했을 때 데이터를 서버에 post하고 화면을 dismiss하기 위한 notification 수신
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("feedPostCheckButtonTapped"), object: nil)
    }
}


// MARK: Extension

extension FeedPostPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitReviewPhotoCollectionViewCell.cellID, for: indexPath) as! VisitReviewPhotoCollectionViewCell
        
        cell.photoImageView.image = images[indexPath.row]
        
        return cell
    }
    
    /// 셀 별 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCollectionView.frame.height - 1, height: photoCollectionView.frame.height - 1)
    }
}

/// placeholder를 위한 TextView extension
extension FeedPostPageVC: UITextViewDelegate {
    /// 입력 시작하면 placeholder 사라지도록 설정
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "당신의 한마디를 입력해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
        
        /// 업로드 가능 여부 판별
        isContentFilled = true
        checkUploadPossible()
    }

    /// placeholder 글자 수 0일 때 나타나도록 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "당신의 한마디를 입력해주세요."
            textView.textColor = .lightGray
        }
        
        /// 업로드 가능 여부 판별
        isContentFilled = false
        checkUploadPossible()
    }
}

/// 갤러리에서 이미지 가져오게 하는 기능 구현
extension FeedPostPageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func didAddPostPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    /// present된 imagePicker에서 이미지를 선택하면 그 이미지가 profileButton의 이미지로 설정되도록 구현
    /// 이후 imagePicker를 dismiss함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            /// 선택된 이미지를 images 배열에 추가해 화면에 표시되도록 구현
            images.append(image)
            photoCollectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}


struct FeedPostPageVC_Preview: PreviewProvider {
    static var previews: some View {
        FeedPostPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

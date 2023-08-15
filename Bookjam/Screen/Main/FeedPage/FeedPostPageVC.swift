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
        $0.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
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
        $0.setTitleColor(main03, for: .normal)
        $0.backgroundColor = main01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = main03?.cgColor
        $0.layer.borderWidth = 0.7
    }
    
    var activityEmptyImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "emptyActivity")
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
        $0.addTarget(self, action: #selector(didPlayGroundButtonTapped), for: .touchUpInside)
    }
    
    var libraryButton: UIButton = UIButton().then {
        $0.setTitle("독립서점", for: .normal)
        $0.setTitleColor(gray06, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = paragraph02
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
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
        $0.tintColor = main03
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
    
    var bookSearchResultAddressLabel: UILabel = UILabel().then {
        $0.text = "장소"
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
        $0.backgroundColor = main03
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        
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
            activityEmptyImageView
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
            bookStorebutton,
            bookSearchResultImageView,
            bookSearchResultNameLabel,
            bookSearchResultAddressLabel,
            bookSearchResultPublisherLabel
        ].forEach { bookView.addSubview($0) }
        
        [
            reviewContentInfoLabel,
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
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
    
    // MARK: Function
    
    @objc func didPostCustomBackButtonTapped() {
        
    }
    
    @objc func didAddPostPhotoButtonTapped() {
        
    }
    
    /// 선택된 버튼과 아닌 버튼 구분해서 색상 변경
    @objc func didBookStoreButtonTapped() {
        libraryButton.backgroundColor = gray02
        libraryButton.layer.borderColor = gray03?.cgColor
        libraryButton.isSelected = false
        
        playGroundButton.backgroundColor = gray03
        playGroundButton.layer.borderColor = gray03?.cgColor
        playGroundButton.isSelected = false
        
        bookStorebutton.backgroundColor = main01
        bookStorebutton.layer.borderColor = main03?.cgColor
    }
    
    @objc func didPlayGroundButtonTapped() {
        bookStorebutton.backgroundColor = gray02
        bookStorebutton.layer.borderColor = gray03?.cgColor
        bookStorebutton.isSelected = false
        
        libraryButton.backgroundColor = gray03
        libraryButton.layer.borderColor = gray03?.cgColor
        libraryButton.isSelected = false
        
        playGroundButton.backgroundColor = main01
        playGroundButton.layer.borderColor = main03?.cgColor
    }
    
    @objc func didLibraryButtonTapped() {
        bookStorebutton.backgroundColor = gray02
        bookStorebutton.layer.borderColor = gray03?.cgColor
        bookStorebutton.isSelected = false
        
        playGroundButton.backgroundColor = gray03
        playGroundButton.layer.borderColor = gray03?.cgColor
        playGroundButton.isSelected = false
        
        libraryButton.backgroundColor = main01
        libraryButton.layer.borderColor = main03?.cgColor
    }
    
    @objc func didAddressSearchButtonTapped() {
        
    }
    
    @objc func didBookSearchButtonTapped() {
        
    }
}


// MARK: Extension

/// placeholder를 위한 TextView extension
extension FeedPostPageVC: UITextViewDelegate {
    /// 입력 시작하면 placeholder 사라지도록 설정
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "당신의 한마디를 입력해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }

    /// placeholder 글자 수 0일 때 나타나도록 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "당신의 한마디를 입력해주세요."
            textView.textColor = .lightGray
        }
    }
}


struct FeedPostPageVC_Preview: PreviewProvider {
    static var previews: some View {
        FeedPostPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

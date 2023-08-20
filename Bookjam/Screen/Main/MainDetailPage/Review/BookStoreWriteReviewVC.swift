//
//  BookStoreWriteReviewVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

// MARK: - 리뷰 작성 중 날짜 선택 마치면 넘어오는 리뷰 작성 페이지

import PhotosUI
import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreWriteReviewVC: UIViewController {

    // MARK: Variables
    
    /// 이전 VC에서 넘어올 변수들 선언 및 초기화
    var date: String = "2000-01-01"
    
    /// 서버에 post할 때 필요한 placeID 값 선언
    var placeID = 2
    
    /// 서버에 넘길 별점 값 저장할 변수 선언
    var starValue: Float = 0.0
    
    /// 추가 버튼 눌러서 추가하는 이미지 담을 이미지 배열 선언
    var images = [Data]()
    
    var reviewContentView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var contentLabel: UILabel = UILabel().then {
        $0.text = "내용"
        $0.font = title06
    }
    
    var writeReviewView: UIView = UIView().then {
        $0.backgroundColor = gray02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = gray03?.cgColor
    }
    
    var reviewTextView: UITextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = paragraph01
        $0.textColor = gray05
        $0.text = "당신의 한마디를 입력해주세요."
    }
    
    var limitLabel: UILabel = UILabel().then {
        $0.text = "0/300"
        $0.font = captionText01
        $0.textColor = gray05
    }
    
    var addPhotoButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.square.fill.on.square.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 40, weight: .regular, scale: .default)), for: .normal)
        $0.tintColor = gray07
        $0.backgroundColor = gray03
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didAddPhotoButtonTapped), for: .touchUpInside)
    }
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(VisitReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: VisitReviewPhotoCollectionViewCell.cellID)
    }
    
    var reviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var reviewLabel: UILabel = UILabel().then {
        $0.text = "리뷰"
        $0.font = title06
    }
    
    var firstStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = gray03
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var secondStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = gray03
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var thirdStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = gray03
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var fourthStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = gray03
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var fifthStarImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = gray03
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var unsatisfyLabel: UILabel = UILabel().then {
        $0.text = "불편해요"
        $0.font = captionText04
    }
    
    var satisfyLabel: UILabel = UILabel().then {
        $0.text = "편안해요"
        $0.font = captionText04
    }
    
    var uploadButton: UIButton = UIButton().then {
        $0.backgroundColor = gray04
        $0.setTitle("업로드", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didUploadButtonTapped), for: .touchUpInside)
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
        view.backgroundColor = gray01
        hideKeyboard()
        
        // TODO: 나중에 리팩토링 할 때 함수 하나로 통일하고 sender 설정해서 쓸데없는 코드 줄이기
        /// 각각의 별 선택했을 때 별점 설정하고 별 tintcolor 변경
        firstStarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didFirstStarTapped)))
        secondStarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSecondStarTapped)))
        thirdStarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didThirdStarTapped)))
        fourthStarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didFourthStarTapped)))
        fifthStarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didFifthStarTapped)))
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            reviewContentView,
            reviewView
        ].forEach { view.addSubview($0) }
        
        [
            contentLabel,
            writeReviewView,
            addPhotoButton,
            photoCollectionView
        ].forEach { reviewContentView.addSubview($0) }
        
        [
            reviewTextView,
            limitLabel
        ].forEach { writeReviewView.addSubview($0) }
        
        [
            reviewLabel,
            firstStarImageView,
            secondStarImageView,
            thirdStarImageView,
            fourthStarImageView,
            fifthStarImageView,
            unsatisfyLabel,
            satisfyLabel,
            uploadButton
        ].forEach { reviewView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        reviewTextView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        reviewContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(420)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        writeReviewView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(contentLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(150)
        }
        
        limitLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        addPhotoButton.snp.makeConstraints {
            $0.top.equalTo(writeReviewView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(120)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(writeReviewView.snp.bottom).offset(20)
            $0.leading.equalTo(addPhotoButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(reviewContentView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        firstStarImageView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().offset(-100)
            $0.width.height.equalTo(45)
        }
        
        secondStarImageView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().offset(-50)
            $0.width.height.equalTo(45)
        }
        
        thirdStarImageView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(45)
        }
        
        fourthStarImageView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().offset(50)
            $0.width.height.equalTo(45)
        }
        
        fifthStarImageView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().offset(100)
            $0.width.height.equalTo(45)
        }
        
        unsatisfyLabel.snp.makeConstraints {
            $0.top.equalTo(firstStarImageView.snp.bottom).offset(10)
            $0.leading.equalTo(firstStarImageView)
        }
        
        satisfyLabel.snp.makeConstraints {
            $0.top.equalTo(fifthStarImageView.snp.bottom).offset(10)
            $0.trailing.equalTo(fifthStarImageView)
        }
        
        uploadButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
        }
    }
    
    
    // MARK: Function
    
    @objc func didFirstStarTapped() {
        firstStarImageView.tintColor = warning
        [
            secondStarImageView,
            thirdStarImageView,
            fourthStarImageView,
            fifthStarImageView
        ].forEach { $0.tintColor = gray03 }
        
        starValue = 1.0
        
        checkUploadPossible()
    }
    
    @objc func didSecondStarTapped() {
        [
            firstStarImageView,
            secondStarImageView
        ].forEach { $0.tintColor = warning }
        
        [
            thirdStarImageView,
            fourthStarImageView,
            fifthStarImageView
        ].forEach { $0.tintColor = gray03 }
        
        starValue = 2.0
        
        checkUploadPossible()
    }
    
    @objc func didThirdStarTapped() {
        [
            firstStarImageView,
            secondStarImageView,
            thirdStarImageView
        ].forEach { $0.tintColor = warning }
        
        [
            fourthStarImageView,
            fifthStarImageView
        ].forEach { $0.tintColor = gray03 }
        
        starValue = 3.0
        
        checkUploadPossible()
    }
    
    @objc func didFourthStarTapped() {
        [
            firstStarImageView,
            secondStarImageView,
            thirdStarImageView,
            fourthStarImageView
        ].forEach { $0.tintColor = warning }
        
        [
            fifthStarImageView
        ].forEach { $0.tintColor = gray03 }
        
        starValue = 4.0
        
        checkUploadPossible()
    }
    
    @objc func didFifthStarTapped() {
        [
            firstStarImageView,
            secondStarImageView,
            thirdStarImageView,
            fourthStarImageView,
            fifthStarImageView
        ].forEach { $0.tintColor = warning }
        
        starValue = 5.0
        
        checkUploadPossible()
    }
    
    /// 업로드 버튼 누르면 화면 닫고 디테일 페이지로 글 작성 완료 토스트 메시지를 띄우기 위한 notification 전송
    @objc func didUploadButtonTapped() {
        /// 장소 리뷰 게시 API 호출
        APIManager.shared.postData(
            urlEndpointString: Constant.postPlacesReviews(placeId: placeID),
            responseDataType: APIModel<ReviewContentResponseModel>?.self,
            requestDataType: ReviewContentRequestModel.self,
            parameter: ReviewContentRequestModel(
                visitedAt: date,
                contents: reviewTextView.text,
                rating: starValue
            )) { response in
                /// 리뷰 게시 성공하면 reviewID 반환받아서 이미지 업로드 API 호출
                if response?.message! == "성공" && response?.result?.reviewId != nil {
                    /// 장소 사진 게시 API 연결
                    APIManager.shared.postImage(
                        urlEndpointString: Constant.postReviewsImages(reviewId: (response?.result?.reviewId)!),
                        responseDataType: APIModel<ReviewImageResponseModel>?.self,
                        images: self.images) { response in
                            print(response)
                        }
                }
            }
        
        /// 디테일 페이지로 다시 복귀
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllerStack {
            if let detailVC = viewController as? BookstoreDetailPageVC {
                navigationController?.popToViewController(detailVC, animated: true)
            }
        }
        
        /// 토스트 메시지를 띄우기 위한 notification 전송
        NotificationCenter.default.post(Notification(name: Notification.Name("uploadButtonTapped")))
    }
    
    /// 리뷰 내용 바뀌면 글자 수 업데이트해주는 함수
    private func updateCountLabel(characterCount: Int) {
        limitLabel.text = "\(characterCount)/300"
    }
    
    /// 리뷰 업로드 조건 확인 함수
    func checkUploadPossible() {
        if reviewTextView.text != "당신의 한마디를 입력해주세요." && starValue != 0 {
            uploadButton.backgroundColor = main03
            uploadButton.isEnabled = true
        }
        else {
            uploadButton.backgroundColor = gray04
            uploadButton.isEnabled = false
        }
    }
}

extension BookStoreWriteReviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitReviewPhotoCollectionViewCell.cellID, for: indexPath) as! VisitReviewPhotoCollectionViewCell
        
        cell.photoImageView.image = UIImage(data: images[indexPath.row])
        
        return cell
    }
    
    /// 셀 별 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCollectionView.frame.height - 1, height: photoCollectionView.frame.height - 1)
    }
}


/// placeholder와 최대 글자 수 제한을 위한 TextView extension
extension BookStoreWriteReviewVC: UITextViewDelegate {
    /// 입력 시작하면 placeholder 사라지도록 설정
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "당신의 한마디를 입력해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
        
        checkUploadPossible()
    }

    /// placeholder 글자 수 0일 때 나타나도록 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "당신의 한마디를 입력해주세요."
            textView.textColor = .lightGray
            updateCountLabel(characterCount: 0)
        }
        
        checkUploadPossible()
    }

    /// 글자 수 입력은 300자까지만 가능하도록 설정
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 300 else { return false }
        updateCountLabel(characterCount: characterCount)

        return true
    }
}

/// 갤러리에서 이미지 가져오게 하는 기능 구현
extension BookStoreWriteReviewVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func didAddPhotoButtonTapped() {
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
            images.append((image.jpegData(compressionQuality: 0.5))!)
            photoCollectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}

struct BookStoreWriteReviewVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreWriteReviewVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

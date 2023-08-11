//
//  BookStoreWriteReviewVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreWriteReviewVC: UIViewController {

    // MARK: Variables
    
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
    
    var reviewTextField: UITextField = UITextField().then {
        $0.placeholder = "당신의 한마디를 입력해주세요."
        $0.font = paragraph01
    }
    
    var limitLabel: UILabel = UILabel().then {
        $0.text = "0/300"
        $0.font = captionText01
        $0.textColor = gray05
    }
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    }).then {
        $0.backgroundColor = .black
        // $0.register(<#T##nib: UINib?##UINib?#>, forCellWithReuseIdentifier: <#T##String#>)
    }
    
    var reviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var firstStarButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    var secondStarButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    var thirdStarButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    var fourthStarButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    var fifthStarButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
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
        $0.backgroundColor = main03
        $0.setTitle("업로드", for: .normal)
        $0.setTitleColor(.white, for: .normal)
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
        view.backgroundColor = gray01
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
            photoCollectionView
        ].forEach { reviewContentView.addSubview($0) }
        
        [
            reviewTextField,
            limitLabel
        ].forEach { writeReviewView.addSubview($0) }
        
        [
            firstStarButton,
            secondStarButton,
            thirdStarButton,
            fourthStarButton,
            fifthStarButton,
            unsatisfyLabel,
            satisfyLabel,
            uploadButton
        ].forEach { reviewView.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        reviewContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        writeReviewView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(contentLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(220)
        }
        
        reviewTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        limitLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
//        photoCollectionView.snp.makeConstraints {
//            $0.top.equalTo(writeReviewView.snp.bottom).offset(20)
//            $0.leading.equalToSuperview().offset(20)
//            $0.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-20)
//        }
    }
    
}

// TODO: func 안 양식 다시 작성 및 flowLayout 추가
extension BookStoreWriteReviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        return cell
    }
}

struct BookStoreWriteReviewVC_Preview: PreviewProvider {
    static var previews: some View {
        BookStoreWriteReviewVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

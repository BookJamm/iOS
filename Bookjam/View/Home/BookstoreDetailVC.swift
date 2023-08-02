//
//  BookstoreDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/28.
//

import SafariServices
import SwiftUI
import UIKit

import SnapKit
import Then

class BookstoreDetailVC: UIViewController {

    // MARK: Variables
    
    private var tabVC: [UIViewController] = [
        BookStoreDetailHomeView(),
        BookStoreDetailNewsView(),
        BookStoreDetailActivityView(),
        BookStoreDetailReviewView(),
        BookStoreDetailBookListView()
    ]
    
    var contentView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var photoStackView: UIStackView = UIStackView().then {
        $0.spacing = 1
    }
    
    var firstPhotoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        // $0.contentMode = .scaleAspectFit
    }
    
    var photoCollectionView: UIStackView = UIStackView().then {
        $0.backgroundColor = .brown
    }
    
    var bookstoreLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "천천히스미는"
        $0.sizeToFit()
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var storeTypeLabel : UILabel = UILabel().then {
        $0.font = paragraph04
        $0.textColor = gray06
        $0.text = "독립서점"
        $0.sizeToFit()
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "4.53"
    }
    
    var reviewCountLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 132"
        $0.sizeToFit()
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.tintColor = gray07
    }
    
    var clockImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "clock.fill")
        $0.tintColor = gray07
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "경기도 수원시 팔달구 매산로52번길 20"
    }
    
    var timeLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = alert
        $0.text = "영업 종료"
    }
    
    var siteURL: UIButton = UIButton().then {
        $0.setTitle("https://youz2me.notion.site/UIButton-ffc98dbfc08740ea9f16bec8e00d204f?pvs=4", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didURLTapped), for: .touchUpInside)
    }
    
    var dividerView: UIView = UIView().then {
        $0.backgroundColor = gray02
    }
    
    var segmentController: UISegmentedControl = UISegmentedControl().then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: gray04!,
            NSAttributedString.Key.font: paragraph03
        ], for: .normal)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: main03!,
            NSAttributedString.Key.font: paragraph03
        ], for: .selected)
        
        $0.insertSegment(withTitle: "홈", at: 0, animated: true)
        $0.insertSegment(withTitle: "소식", at: 1, animated: true)
        $0.insertSegment(withTitle: "참여", at: 2, animated: true)
        $0.insertSegment(withTitle: "리뷰", at: 3, animated: true)
        $0.insertSegment(withTitle: "책 종류", at: 4, animated: true)

        $0.selectedSegmentIndex = 0
        
        $0.addTarget(self, action: #selector(didSegmentControllerValueChanged), for: .valueChanged)
    }
    
    var segmentControlUnderlineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var segmentControlSelectedUnderLineView: UIView = UIView().then {
        $0.backgroundColor = main03
    }
    
    var homeView: BookStoreDetailHomeView = BookStoreDetailHomeView()
    var newsView: BookStoreDetailNewsView = BookStoreDetailNewsView()
    var activityView: BookStoreDetailActivityView = BookStoreDetailActivityView()
    var bookListView: BookStoreDetailBookListView = BookStoreDetailBookListView()
    var reviewView: BookStoreDetailReviewView = BookStoreDetailReviewView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(contentView)
        [
            photoStackView,
            bookstoreLabel,
            bookMarkImageView,
            storeTypeLabel,
            starImageView,
            starLabel,
            reviewCountLabel,
            underLineView,
            locationPinImageView,
            clockImageView,
            locationLabel,
            timeLabel,
            siteURL,
            dividerView,
            segmentController,
            segmentControlUnderlineView,
            segmentControlSelectedUnderLineView
        ].forEach { contentView.addSubview($0) }
        
        photoStackView.addArrangedSubview(firstPhotoImageView)
        photoStackView.addArrangedSubview(photoCollectionView)
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        photoStackView.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        firstPhotoImageView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(200)
        }

        photoCollectionView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
            $0.height.equalToSuperview()
        }

        bookstoreLabel.snp.makeConstraints {
            $0.left.equalTo(photoStackView).offset(15)
            $0.bottom.equalTo(photoStackView).multipliedBy(1.2)
        }

        bookMarkImageView.snp.makeConstraints {
            $0.right.equalTo(bookstoreLabel).offset(30)
            $0.centerY.equalTo(bookstoreLabel)
        }

        storeTypeLabel.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.bottom.equalTo(bookstoreLabel).offset(30)
        }

        starImageView.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        starLabel.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel).offset(25)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        reviewCountLabel.snp.makeConstraints {
            $0.left.equalTo(starLabel).offset(45)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        underLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.93)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(starImageView).offset(20)
        }

        locationPinImageView.snp.makeConstraints {
            $0.left.equalTo(starImageView)
            $0.bottom.equalTo(underLineView).offset(40)
        }

        locationLabel.snp.makeConstraints {
            $0.left.equalTo(locationPinImageView).offset(25)
            $0.centerY.equalTo(locationPinImageView)
        }

        clockImageView.snp.makeConstraints {
            $0.centerX.equalTo(locationPinImageView)
            $0.bottom.equalTo(locationPinImageView).offset(30)
        }

        timeLabel.snp.makeConstraints {
            $0.left.equalTo(clockImageView).offset(25)
            $0.centerY.equalTo(clockImageView)
        }

        siteURL.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.left.equalTo(clockImageView)
            $0.bottom.equalTo(clockImageView).offset(35)
        }

        dividerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(15)
            $0.top.equalTo(siteURL.snp.bottom).offset(10)
        }

        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(dividerView.snp.bottom).offset(5)
        }

        segmentControlUnderlineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }

        segmentControlSelectedUnderLineView.snp.makeConstraints {
            $0.width.equalTo(segmentController).dividedBy(5)
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }
    }
    
    
    // MARK: Functions
    
    // TODO: 나중에 연결할 인스타 링크 여기에 연결
    @objc func didURLTapped() {
        let url = NSURL(string: "https://youz2me.notion.site/UIButton-ffc98dbfc08740ea9f16bec8e00d204f?pvs=4")
        let instaView: SFSafariViewController = SFSafariViewController(url: url! as URL)
        
        self.present(instaView, animated: true, completion: nil)
    }
    
    @objc private func didSegmentControllerValueChanged() {
        let segmentIndex = CGFloat(segmentController.selectedSegmentIndex)
        let segmentWidth = segmentController.frame.width / CGFloat(segmentController.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            guard let self = self else { return }
            self.segmentControlSelectedUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(10 + leadingDistance)
            }
        })
    }
}

struct BookstoreDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        BookstoreDetailVC().toPreview()
            .previewLayout(.sizeThatFits)
            // .edgesIgnoringSafeArea(.all)
    }
}


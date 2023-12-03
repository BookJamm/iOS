//
//  MainDetailNewsTableViewController.swift
//  BookJam
//
//  Created by 장준모 on 11/30/23.
//

import UIKit

class MainDetailNewsUIView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var bookStoreName = "책방연희"
    
    var bookPlaceLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책방 이름의 소식"
    }
    var newsCollectionView: UICollectionView = UICollectionView().then {
        $0.register(BookNewsCollectionViewCell.self, forCellWithReuseIdentifier: BookNewsCollectionViewCell.id)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setUpView()
        setUpLayout()
        setUpDelegate()
    }

    // MARK: View
    
    func setUpView() {
        newsCollectionView.isScrollEnabled = false
        
        bookPlaceLabel.text = "\(bookStoreName)의 소식"
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {

        [
            bookPlaceLabel,
            newsCollectionView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        self.newsCollectionView.dataSource = self
        self.newsCollectionView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {

        bookPlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        newsCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookPlaceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

extension MainDetailNewsUIView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: BookNewsCollectionViewCell.id, for: indexPath) as! BookNewsCollectionViewCell
        
        // TODO: api 데이터 넣어주기
        cell.configure(title: "임시", content: "소식입니다.")
        return cell
    }
}

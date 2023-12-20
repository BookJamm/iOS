//
//  BookStoreDetailNewsView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 페이지 소식 탭 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreDetailNewsView: UIView {

    // MARK: Variables
    
    var bookStoreName = "책방연희"
    
    // 소식 탭에 들어갈 데이터 News 배열로 구현
    var newsList1: [News] = [
        News(storePhoto: "squareDefaultImage", title: "8월 4일 ~ 8월 9일 휴가갑니다!", content: "이번 연휴 기간동안 휴무입니다 :) 좋은 연휴 보내세요", date: "2023. 07. 23", photo: ""),
        News(storePhoto: "squareDefaultImage", title: "<책방 연희> 7기 종강", content: "갑자기 억수가 퍼부었던 7월의 마지막 일요일인 오늘, 『나만의 엽서북 만들기』 with <책방 연희> 7기를 마무리했습니다.", date: "2023. 06. 28", photo: ""),
        News(storePhoto: "squareDefaultImage", title: "새로운 독립 출판물 출판", content: "새로운 독립 출판물이 출판되었습니다! 많은 관심 부탁드립니다", date: "2023. 05. 07", photo: "")
    ]
    
    var newsList: [PlaceIdNewsResponseModel] = []
    
    var bookPlaceLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.text = "책방 이름의 소식"
    }
    
    var newsTableView: UITableView = UITableView().then {
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }


    // MARK: View
    
    func setUpView() {
        newsTableView.isScrollEnabled = false
        newsTableView.separatorStyle = .none
        newsTableView.rowHeight = UITableView.automaticDimension
        
        bookPlaceLabel.text = "\(bookStoreName)의 소식"
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {

        [
            bookPlaceLabel,
            newsTableView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {

        bookPlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        newsTableView.snp.makeConstraints {
            $0.top.equalTo(bookPlaceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Func
    func getNewsViewHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        for news in newsList {
//            let contentHeight = calculateContentHeight(news.content)
            let contentHeight = calculateContentHeight(news.contents!)

            // 셀 간의 여백 등을 고려한 추가적인 여백 값을 더해줄 수도 있음
            
            totalHeight += ( contentHeight )
        }
        
        // 최종 높이에 뷰의 여백 등을 더해줄 수도 있음
        return totalHeight 
    }
            
    func calculateContentHeight(_ content: String) -> CGFloat {
        // 콘텐츠의 길이에 따라 높이를 계산하여 반환하는 로직을 구현
        // 예를 들어 content의 길이에 따라 적절한 높이 값을 계산하는 방식
        // 여기서는 예시로 임의의 값을 반환하도록 했습니다.
        
        if content.count < 30 { return 100 }
        else if content.count >= 18 && content.count < 36 { return 150 }
        else if content.count >= 30 && content.count < 36 { return 170 }
        else { return 170 }
    }
    
}

// 소식 탭에 들어갈 소식 셀 삽입을 위한 Delegate, DataSource extension
extension BookStoreDetailNewsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    // 소식 셀 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.profileImageView.image = UIImage(named: "squareDefaultImage" )?.circularImage()
        cell.newsLabel.text = newsList[indexPath.row].title
        cell.newsContent.text = newsList[indexPath.row].contents
        cell.newsDate.text = newsList[indexPath.row].createdAt!.components(separatedBy: "T")[0]
        
        cell.selectionStyle = .none

        return cell
    }
    
    /// 글 길이에 맞게 뷰 높이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct BookStoreDetailNewsView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let button = BookStoreDetailNewsView()
//            return button
//        }
//        .previewLayout(.sizeThatFits)
//        .padding(10)
//    }
//}
//#endif

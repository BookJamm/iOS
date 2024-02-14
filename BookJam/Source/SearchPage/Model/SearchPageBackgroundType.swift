//
//  SearchPageBackground.swift
//  BookJam
//
//  Created by 박민서 on 2/5/24.
//

import UIKit

// SearchPage의 기본 배경화면의 타입 enum입니다
enum SearchPageBackgroundType {
    case start
    case noResult
    
    var image:UIImage {
        switch self {
        case .start:
            return UIImage.landingImage01
        case .noResult:
            return UIImage.landingImage03
        }
    }
    
    var title:String {
        switch self {
        case .start:
            return "새로운 독립서점을 찾아보세요"
        case .noResult:
            return "독립서점 결과가 없어요"
        }
    }
    
    var subTitle:String {
        switch self {
        case .start:
            return "서점 이름 또는 주소를 입력하여\n여러분의 취향에 맞는 장소를 찾아보세요."
        case .noResult:
            return "정보가 누락이 되었다면,\n북잼 문의사항을 이용해주세요."
        }
    }
}

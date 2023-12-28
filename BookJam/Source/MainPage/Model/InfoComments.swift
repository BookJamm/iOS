//
//  InfoComments.swift
//  BookJam
//
//  Created by 박민서 on 12/27/23.
//

extension Category {
    
    /// 해당 카테고리의 소개 정보 문구 입니다.
    var infoComment: String {
        switch self {
        case .BookStore:
            return "독립 서점은 대규모 자본, 큰 유통망에 의지하지 않고 꾸며진 작은 서점을 의미해요 :)"
        case .BookClub:
            return "독서 모임 :)"
        case .Pulication:
            return "독립 출판물 :)"
        }
    }
}

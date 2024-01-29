//
//  BookClubCategory.swift
//  BookJam
//
//  Created by 박민서 on 1/28/24.
//

/// 모임의 카테고리 입니다.
enum BookClubCategory: CaseIterable {
    /// 전체
    case all
    /// 인문학
    case humanities
    /// 커리어/자기개발
    case careerDevelopment
    /// 학문/글쓰기
    case academicWriting
    /// 예술/문학
    case artsLiterature
    /// 과학/철학
    case sciencePhilosophy
    /// 사회/이슈
    case socialIssues
        
    var toKorean:String {
        switch self {
        
        case .all:
            return "전체"
        case .humanities:
            return "인문학"
        case .careerDevelopment:
            return "커리어/자기개발"
        case .academicWriting:
            return "학문/글쓰기"
        case .artsLiterature:
            return "예술/문학"
        case .sciencePhilosophy:
            return "과학/철학"
        case .socialIssues:
            return "사회/이슈"
        }
    }    
}

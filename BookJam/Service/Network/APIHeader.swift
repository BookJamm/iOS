//
//  APIHeader.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

import Foundation
import Alamofire

//enum APIHeader {
//
//    
//    case header
//    case sendImageHeader
//    
//    var getValue: HTTPHeaders {
//        switch self {
//        case .header :
//            return [    //임시 슈퍼 jwt 토큰
////                "Authorization": "Bearer \(APIHeader.jwtToken)"
//            ]
//        case .sendImageHeader :
//            return [
////                "Authorization": "Bearer \(APIHeader.jwtToken)",
//                "Content-Type" : "multipart/form-data"
//            ]
//        }
//    }
//
//    // 추후 Token 로직 구현되었을 때 예시 with KeyChain
////    case .logout:
////        return ["Authorization": KeyChain.shared.read(account: .accessToken),
////                "Refresh-Token": KeyChain.shared.read(account: .refreshToken),
////                "Content-Type": "application/json"]
////    default:
////        return ["Authorization": KeyChain.shared.read(account: .accessToken),
////                "Content-Type": "application/json"]
//}

extension APIEndPoint {
    // 사용 시 접근 예시 : APIEndPoint.getAuthFriends.header
    var header: HTTPHeaders {
        switch self {
            
            // 토큰 필요 없는 경우 default 값 반환
        case .postAuthEmailCheck, .getAuthFriends, .postAuthLogin, .getSearchUser:
            return HTTPHeaders()
            
            // 토큰 필요한 API 경우 토큰 반환
        case .getUsersOutline, .getUsersActivities, .getUsersReviews, .getUsersRecords, .getPlaces, .getPlacesSearch, .getPlaceId, .getPlaceNewsURL, .getPlaceBooksURL, .getPlaceActivitiesURL, .getPlaceReviewsURL, .postPlacesReviews, .getBooksList, .postRecord, .getRecordsFriends:
            return [    //임시 슈퍼 jwt 토큰
                "Authorization": "Bearer \(APIEndPoint.jwtToken)"
            ]
            
            // 이미지 POST인 경우 multipart/form-data 추가
        case .postReviewsImages, .postRecordsImages:
            return [
                "Authorization": "Bearer \(APIEndPoint.jwtToken)",
                "Content-Type" : "multipart/form-data"
            ]
        }
    }
}

//
//  APIEncoder.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation
import Alamofire

extension APIEndPoint {
    // 사용 시 접근 예시 : APIEndPoint.getAuthFriends.method
    var encoder: ParameterEncoder {
        switch self {
            
            // parameter가 일반 쿼리스트링으로 들어가거나, 없는 경우
        case .getAuthFriends, .getSearchUser, .getUsersOutline, .getUsersActivities, .getUsersReviews, .getUsersRecords, .getPlaces, .getPlacesSearch, .getPlaceId,  .getPlaceNewsURL, .getPlaceBooksURL, .getPlaceActivitiesURL, .getPlaceReviewsURL, .getBooksList, .getRecordsFriends:
            return URLEncodedFormParameterEncoder.default
            
            // parameter를 JSON으로 파싱해서 넣어줘야 하는 경우
        case .postAuthLogin, .postAuthEmailCheck, .postPlacesReviews, .postReviewsImages, .postRecord, .postRecordsImages:
            return .json
        }
    }
}

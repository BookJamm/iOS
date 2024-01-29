//
//  APIMethod.swift
//  BookJam
//
//  Created by 박민서 on 11/30/23.
//

import Foundation

extension APIEndPoint {
    // 사용 시 접근 예시 : APIEndPoint.getAuthFriends.method
    var method: HTTPMethod {
        switch self {
            
        case .getAuthFriends, .getSearchUser, .getUsersOutline, .getUsersActivities, .getUsersReviews, .getUsersRecords, .getPlaces, .getPlacesSearch, .getPlaceId,  .getPlaceNewsURL, .getPlaceBooksURL, .getPlaceActivitiesURL, .getPlaceReviewsURL, .getBooksList, .getRecordsFriends:
            return .get
            
        case .postAuthLogin, .postAuthEmailCheck, .postPlacesReviews, .postReviewsImages, .postRecord, .postRecordsImages:
            return .post
        }
    }
}

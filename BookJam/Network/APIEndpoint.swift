//
//  Endpoint.swift
//  BookJam
//
//  Created by 박민서 on 11/23/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidDataEncoding
    case requestFailed(Error)
    case invalidResponse
    case responseDataDecodingFailed(Error)
}

//enum HTTPMethod: String {
//
//}


enum APIEndPoint {
    static let baseURL = "https://bookjam.shop"
    // Auth
    case postAuthEmailCheck
    case getAuthFriends
    case postAuthLogin
    
    // User
    case getSearchUser
    case getUsersOutline
    case getUsersActivities
    case getUsersReviews
    case getUsersRecords(category: Int)
    
    // Place
    case getPlaces
    case getPlacesSearch
    case getPlaceId(placeId: Int)
    case getPlaceNewsURL(placeId: Int)
    case getPlaceBooksURL(placeId: Int)
    case getPlaceActivitiesURL(placeId: Int)
    case getPlaceReviewsURL(placeId: Int)
    case postPlacesReviews(placeId: Int)
    case postReviewsImages(reviewId: Int)
    
    // Book
    case getBooksList(title: String)
    
    // Record
    case postRecord
    case getRecordsFriends
    case postRecordsImages(recordId: Int)
    
    // 사용 시 접근 예시 : APIEndPoint.getAuthFriends.url
    var url: String {
        switch self {
        // Auth
        case .postAuthEmailCheck:
            return "/auth/email-check"
        case .getAuthFriends:
            return "/auth/friends"
        case .postAuthLogin:
            return "/auth/login"
        // User
        case .getSearchUser:
            return "/user/search"
        case .getUsersOutline:
            return "/users/outline"
        case .getUsersActivities:
            return "/users/activities"
        case .getUsersReviews:
            return "/users/reviews"
        case .getUsersRecords(let category):
            return "/users/records?category=\(category)"
        // Place
        case .getPlaces:
            return "/places"
        case .getPlacesSearch:
            return "/places/search"
        case .getPlaceId(let placeId):
            return "/places/\(placeId)"
        case .getPlaceNewsURL(let placeId):
            return "/places/\(placeId)/news"
        case .getPlaceBooksURL(let placeId):
            return "/places/\(placeId)/books"
        case .getPlaceActivitiesURL(let placeId):
            return "/places/\(placeId)/activities"
        case .getPlaceReviewsURL(let placeId):
            return "/places/\(placeId)/reviews"
        case .postPlacesReviews(let placeId):
            return "/places/\(placeId)/reviews"
        case .postReviewsImages(let reviewId):
            return "/reviews/\(reviewId)/images"
        // Book
        case .getBooksList(let title):
            return "/books/list?title=\(title)"
            
        // Record
        case .postRecord:
            return "/records"
        case .getRecordsFriends:
            return "/records/friends"
        case .postRecordsImages(let recordId):
            return "/records/\(recordId)/images"
        }
        
    }
}

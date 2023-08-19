//
//  APIConstant.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation


struct Constant {
    static let baseURL = "https://bookjam.shop"
    
    static let postEmailDuplicate = "/auth/email-check"
    static let recommendFriend = "/auth/friends"
    static let searchFriend = "/user/search"
    static let userLogin = "/auth/login"
    static let getPlaces = "/places"
    static let keywordSearch = "/places/search"
    static let postRecord = "/records"
    static func getPlaceId(placeId: Int) -> String {
        return "/places/\(placeId)"}
    static func getPlaceNewsURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/news"}
    static func getPlaceBooksURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/books"}
    static func getPlaceActivitiesURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/activities"}
    static let getPlaceId = "/places/:placeId"
    var postReviewContent = "places/:placeId/reviews"
    
    init(placeId: Int) {
        self.postReviewContent = "places/\(placeId)/reviews"
    }
}

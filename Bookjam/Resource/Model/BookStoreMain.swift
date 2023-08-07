//
//  BookStoreMain.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/06.
//

import Foundation
import UIKit

struct bookStoreMain{
    let bookStoreTitle: String
    let bookStoreAddress: String
    let bookStoreReviewScore: String
    let bookStoreReviewNumber: String
    
    let image1: String?
    let image2: String?
    let image3: String?
    
    init(title: String, address: String, reviewScore: String, reviewNumber: String,
             image1: String? = nil, image2: String? = nil, image3: String? = nil) {
            self.bookStoreTitle = title
            self.bookStoreAddress = address
            self.bookStoreReviewScore = reviewScore
            self.bookStoreReviewNumber = reviewNumber
            self.image1 = image1
            self.image2 = image2
            self.image3 = image3
        }
    
}

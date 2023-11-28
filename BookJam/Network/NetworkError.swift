//
//  NetworkError.swift
//  BookJam
//
//  Created by 박민서 on 11/28/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidDataEncoding
    case requestFailed(Error)
    case invalidResponse
    case responseDataDecodingFailed(Error)
}

//
//  BookJamAPI.swift
//  BookJam
//
//  Created by 박민서 on 11/23/23.
//

import Foundation

import Alamofire
import RxSwift


class APIManager: ObservableObject  {
    static let shared = APIManager()
    private lazy var headers: HTTPHeaders = [    //임시 슈퍼 jwt 토큰
        "Authorization": "Bearer \(jwtToken)"
    ]
    
    func setHeaderToSendImage() -> HTTPHeaders {
        headers = [
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type" : "multipart/form-data"
        ]
        return headers
    }
    
    // 얘네 테스트용이니 다 날려야 함
    let jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMzLCJpYXQiOjE2OTIwMDExNDQsImV4cCI6MTc5MjAwNDc0NCwiaXNzIjoiYm9va2phbSJ9.BGN1CGC4Zu8xRVuH_zA-aTK1GYMWvNitR2mAfgG1zWU"

    let kakaoAppID = "e71c9521872b70f64acf3a7139889342"
}

// MARK: T에는 요청값 데이터의 모델, U에는 응닶값 데이터의 모델 적기
extension APIManager {
    func getData<T: Encodable, U: Decodable>(urlEndpointString: APIEndPoint,
                                           responseDataType: U.Type,
                                           requestDataType: T.Type,
                                           parameter: T?
    ) -> Observable<U>{
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        print("get 요청 URL --> \(url)")
        print("Request 쿼리 --> \(String(describing: parameter))")
        
        
        return Observable.create { emitter in
            AF
                .request(url, method: .get, parameters: parameter, headers: self.headers)
//                .validate(statusCode: 200..<300) // validation code를 몰라요
                .responseDecodable(of: BaseResponse<U>.self) { response in
                    print(response)
                    switch response.result {
                    case .success(let success):
                        if let result = success.result {
                            emitter.onNext(result)
                        }
                        else {
                            emitter.onError(NetworkError.invalidResponse)
                        }
                    case .failure(let error):
//                        print(error.localizedDescription)
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func postData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else { return }
        print("post 요청 URL --> \(url)")
        print("Request 쿼리 --> \(parameter)")

        AF
            .request(url, method: .post, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                //print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    /// 서버에 이미지 post할 때 사용합니다.
    /// request 타입은 정의할 필요 없고 들어갈 이미지 배열을 파라미터에 넣어주세요.
    func postImage<U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            images: [Data],
                                            completionHandler: @escaping (U)->Void) {
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else { return }
        print("post image 요청 URL --> \(url)")
        
        AF.upload(multipartFormData: { MultipartFormData in
            for image in images {
                MultipartFormData.append(image, withName: "images", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: url, method: .post, headers: setHeaderToSendImage())
        .validate()
        .responseDecodable(of: U.self) { response in
            print(response)
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .responseString(completionHandler: { response in
            print(response)
        })
        .resume()
    }
    
    func patchData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else { return }
        print("patch 요청 URL --> \(url)")
        print("Request 쿼리 --> \(parameter)")
        
        AF
            .request(url, method: .patch, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                //print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func deleteData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else { return }
        print("patch 요청 URL --> \(url)")
        print("Request 쿼리 --> \(parameter)")
        
        AF
            .request(url, method: .delete, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                //print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

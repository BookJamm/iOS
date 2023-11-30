//
//  BookJamAPI.swift
//  BookJam
//
//  Created by 박민서 on 11/23/23.
//

import Foundation

import Alamofire
import RxSwift

// MARK: 싱글톤 매니저로 관리됩니다.
class APIManager: ObservableObject  {
    static let shared = APIManager()
}

// MARK: Request Wrapper 함수입니다.
extension APIManager {
    
    /// get, post, patch, delete와 같은 일반적인 요청을 수행하는 함수입니다.
    /// endpoint에 해당 요청에 맞는 APIEndPoint를 설정하세요.
    /// requestData에는 요청값 데이터, responseDataType에는 응닶값 데이터의 모델(data.self)을 입력하세요
    func requestData<T: Encodable, U:Decodable>(endpoint: APIEndPoint,
                                                requestData: T?,
                                                responseDataType: U.Type
    ) -> Observable<U> {
        
        // EndPoint merging
        guard let url = URL(string: APIEndPoint.baseURL + endpoint.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("endpoint URL --> \(url)")
        if let queryString = requestData { print("Request 쿼리 --> \(queryString)") }
        
        return Observable.create { emitter in
            AF.request(url,
                       method: endpoint.method,
                       parameters: requestData,
                       encoder: endpoint.encoder,
                       headers: endpoint.header
            )
            .responseDecodable(of: BaseResponse<U>.self) { response in
                switch response.result {
                case .success(let success):
                    if let result = success.result {
                        emitter.onNext(result)
                    }
                    else {
                        emitter.onError(NetworkError.invalidResponse)
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
    /// request 타입은 정의할 필요 없고 들어갈 이미지 배열을 파라미터에 넣어주세요.
    /// 서버에 이미지들을 POST하는 기능을 수행하는 함수입니다.
    /// endpoint에 해당 요청에 맞는 APIEndPoint를 설정하세요.
    /// images에는 이미지 Data 배열, responseDataType에는 응닶값 데이터의 모델(data.self)을 입력하세요
    func postImage<U: Decodable>(endpoint: APIEndPoint,
                                            responseDataType: U.Type,
                                            images: [Data]
    ) -> Observable<U> {
        guard let url = URL(string: APIEndPoint.baseURL + endpoint.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("post image 요청 URL --> \(url)")
        
        return Observable.create { emitter in
        
            AF.upload(multipartFormData: { MultipartFormData in
                for image in images {
                    MultipartFormData.append(image, withName: "images", fileName: "\(image).png", mimeType: "image/png")
                }
            },
                      to: url,
                      method: endpoint.method,
                      headers: endpoint.header)
            .validate() // 200~299
            .responseDecodable(of: BaseResponse<U>.self) { response in
                switch response.result {
                case .success(let success):
                    if let result = success.result {
                        emitter.onNext(result)
                    }
                    else {
                        emitter.onError(NetworkError.invalidResponse)
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }
//            .resume()
            
            return Disposables.create()
        }
    }
    
//    // T를 안쓰는 GET 있나?
//    func getData<T: Encodable, U: Decodable>(urlEndpointString: APIEndPoint,
//                                           responseDataType: U.Type,
//                                           requestDataType: T.Type, // 이거 안써줘도 되는거 아닐까
//                                           parameter: T? // 파라미터랑 reqType이랑 같은애?
//    ) -> Observable<U>{
//        
//        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
//            return Observable.error(NetworkError.invalidURL)
//        }
//        
//        print("get 요청 URL --> \(url)")
//        print("Request 쿼리 --> \(String(describing: parameter))") // 이거 디버깅으로 바꿔보자
//        
//        
//        return Observable.create { emitter in
//            AF
//                .request(url, 
//                         method: .get,
//                         parameters: parameter,
//                         headers: APIHeader.header.getValue)
//                .validate()
//                .responseDecodable(of: BaseResponse<U>.self) { response in
//                    print(response)
//                    switch response.result {
//                    case .success(let success):
//                        if let result = success.result {
//                            emitter.onNext(result)
//                        }
//                        else {
//                            emitter.onError(NetworkError.invalidResponse)
//                        }
//                    case .failure(let error):
//                        emitter.onError(error)
//                    }
//                }
//            //                .resume()
//            return Disposables.create()
//        }
//    }
//    
//    func postData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
//                                            responseDataType: U.Type,
//                                            requestDataType: T.Type,
//                                            parameter: T?
//    ) -> Observable<U>{
//        
//        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
//            return Observable.error(NetworkError.invalidURL)
//        }
//        
//        print("post 요청 URL --> \(url)")
//        print("Request 쿼리 --> \(String(describing: parameter))")
//        
//        return Observable.create { emitter in
//            AF
//                .request(url, 
//                         method: .post,
//                         parameters: parameter,
//                         encoder: .json,
//                         headers: APIHeader.header.getValue) // encoder가 파라미터 인코더인가?
//                .validate()
//                .responseDecodable(of: BaseResponse<U>.self) { response in
//                    switch response.result {
//                    case .success(let success):
//                        if let result = success.result {
//                            emitter.onNext(result)
//                        }
//                        else {
//                            emitter.onError(NetworkError.invalidResponse)
//                        }
//                    case .failure(let error):
//                        emitter.onError(error)
//                    }
//                }
//            return Disposables.create()
//        }
//    }
//    
//    func patchData<T: Encodable, U: Decodable>(urlEndpointString: APIEndPoint,
//                                            responseDataType: U.Type,
//                                            requestDataType: T.Type,
//                                            parameter: T?
//    ) -> Observable<U> {
//        
//        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
//            return Observable.error(NetworkError.invalidURL)
//        }
//        
//        print("patch 요청 URL --> \(url)")
//        print("Request 쿼리 --> \(String(describing: parameter))")
//        
//        return Observable.create { emitter in
//            AF
//                .request(url, 
//                         method: .patch,
//                         parameters: parameter,
//                         encoder: .json,
//                         headers: APIHeader.header.getValue)
//                .responseDecodable(of: BaseResponse<U>.self) { response in
//                    switch response.result {
//                    case .success(let success):
//                        if let result = success.result {
//                            emitter.onNext(result)
//                        }
//                        else {
//                            emitter.onError(NetworkError.invalidResponse)
//                        }
//                    case .failure(let error):
//                        emitter.onError(error)
//                    }
//                }
////                .resume()
//            return Disposables.create()
//        }
//    }
//    
//    func deleteData<T: Encodable, U: Decodable>(urlEndpointString: APIEndPoint,
//                                            responseDataType: U.Type,
//                                            requestDataType: T.Type,
//                                            parameter: T?
//    ) -> Observable<U> {
//        
//        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
//            return Observable.error(NetworkError.invalidURL)
//        }
//        
//        print("patch 요청 URL --> \(url)")
//        print("Request 쿼리 --> \(String(describing: parameter))")
//        
//        return Observable.create { emitter in
//            AF
//                .request(url, 
//                         method: .delete,
//                         parameters: parameter,
//                         encoder: .json,
//                         headers: APIHeader.header.getValue)
//                .responseDecodable(of: BaseResponse<U>.self) { response in
//                    switch response.result {
//                    case .success(let success):
//                        if let result = success.result {
//                            emitter.onNext(result)
//                        }
//                        else {
//                            emitter.onError(NetworkError.invalidResponse)
//                        }
//                    case .failure(let error):
//                        emitter.onError(error)
//                    }
//                }
////                .resume()
//            return Disposables.create()
//        }
//    }
}

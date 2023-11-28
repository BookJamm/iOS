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
                .request(url, method: .get, parameters: parameter, headers: APIHeader.header.getValue)
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
                                            parameter: T?
    ) -> Observable<U>{
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("post 요청 URL --> \(url)")
        print("Request 쿼리 --> \(String(describing: parameter))")
        
        return Observable.create { emitter in
            AF
                .request(url, method: .post, parameters: parameter, encoder: .json, headers: APIHeader.header.getValue)
                .responseDecodable(of: BaseResponse<U>.self) { response in
                    //print(response)
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
            return Disposables.create()
        }
    }
    
    /// 서버에 이미지 post할 때 사용합니다.
    /// request 타입은 정의할 필요 없고 들어갈 이미지 배열을 파라미터에 넣어주세요.
    func postImage<U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            images: [Data],
                                            completionHandler: @escaping (U)->Void
    ) -> Observable<U> {
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("post image 요청 URL --> \(url)")
        
        return Observable.create { emitter in
        
            AF.upload(multipartFormData: { MultipartFormData in
                for image in images {
                    MultipartFormData.append(image, withName: "images", fileName: "\(image).png", mimeType: "image/png")
                }
            }, to: url, method: .post, headers: APIHeader.sendImageHeader.getValue)
            .validate() // 어떤 값을 validate 하는 지 확인 필요
            .responseDecodable(of: BaseResponse<U>.self) { response in
//                print(response)
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
//            .responseString(completionHandler: { response in
//                print(response)
//            }) // 이건 response 디버그용?
//            .resume()
            return Disposables.create()
        }
    }
    
    func patchData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?
    ) -> Observable<U> {
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("patch 요청 URL --> \(url)")
        print("Request 쿼리 --> \(String(describing: parameter))")
        
        return Observable.create { emitter in
            AF
                .request(url, method: .patch, parameters: parameter, encoder: .json, headers: APIHeader.header.getValue)
                .responseDecodable(of: BaseResponse<U>.self) { response in
                    //print(response)
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
//                .resume()
            return Disposables.create()
        }
    }
    
    func deleteData<T: Codable, U: Decodable>(urlEndpointString: APIEndPoint,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?
    ) -> Observable<U> {
        
        guard let url = URL(string: APIEndPoint.baseURL + urlEndpointString.url) else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        print("patch 요청 URL --> \(url)")
        print("Request 쿼리 --> \(String(describing: parameter))")
        
        return Observable.create { emitter in
            AF
                .request(url, method: .delete, parameters: parameter, encoder: .json, headers: APIHeader.sendImageHeader.getValue)
                .responseDecodable(of: BaseResponse<U>.self) { response in
                    //print(response)
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
//                .resume()
            return Disposables.create()
        }
    }
}

//
//  APIManager.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

// MARK: 서버와의 API 통신을 위한 APIManager 구현

import Foundation

import Alamofire


class APIManager: ObservableObject  {
    static let shared = APIManager()
    private var headers: HTTPHeaders = [    //임시 슈퍼 jwt 토큰
        "Authorization": "Bearer \(jwtToken)"
    ]

}

// MARK: T에는 요청값 데이터의 모델, U에는 응닶값 데이터의 모델 적기
extension APIManager {
    
    func getData<T: Codable, U: Decodable>(urlEndpointString: String,
                                           responseDataType: U.Type,
                                           requestDataType: T.Type,
                                           parameter: T?,
                                           completionHandler: @escaping (U)->Void
    ) {
        
        guard let url = URL(string: Constant.baseURL + urlEndpointString) else { return }
        print("get 요청 URL --> \(url)")

        print("Request 쿼리 : \(parameter)")
        
        AF
            .request(url, method: .get, parameters: parameter, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func postData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        guard let url = URL(string: Constant.baseURL + urlEndpointString) else { return }
        print("post 요청 URL --> \(url)")

        AF
            .request(url, method: .post, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func patchData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        
        guard let url = URL(string: Constant.baseURL + urlEndpointString) else { return }
        print("patch 요청 URL --> \(url)")
        AF
            .request(url, method: .patch, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func deleteData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (U)->Void) {
        
        guard let url = URL(string: Constant.baseURL + urlEndpointString) else { return }
        print("patch 요청 URL --> \(url)")
        AF
            .request(url, method: .delete, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: U.self) { response in
                print(response)
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

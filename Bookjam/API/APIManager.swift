//
//  APIManager.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation

import Alamofire


private let BASE_URL = "http://Bookjam-dev-env.eba-nshzkmkh.ap-northeast-2.elasticbeanstalk.com"

class APIManager: ObservableObject  {
    static let shared = APIManager()
    
    private var appleId: String = ""
    private var headers: HTTPHeaders?
    
    private func setHeader() {
        self.headers = ["apple-code": appleId]
    }
    
    public func getAppleId() -> String {
        // TODO: UserDefaults에 저장한 유저 식별값 반환
        return appleId
    }
    
    public func setAppleId() {
        if UserDefaults.standard.value(forKey: "appleId") != nil {
            if let appleId = UserDefaults.standard.object(forKey: "appleId") as? String {
                self.appleId = appleId
                setHeader()
            }
        }
    }
}

// MARK: T에는 요청값 데이터의 모델, U에는 응닶값 데이터의 모델 적기
extension APIManager {
    func getData<T: Codable, U: Decodable>(urlEndpointString: String,
                                           responseDataType: U.Type,
                                           requestDataType: T.Type,
                                           parameter: T?,
                                           completionHandler: @escaping (U)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        print("get 요청 URL --> \(url)")

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
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
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
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
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
}

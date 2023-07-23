//
//  LoginAPI.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/21.
//

import Foundation
import Alamofire

struct LoginAPI {
    
   static func emailCheckRequest(email: String) -> Void{
           
       let baseURLString = "https://Bookjam-dev-env.eba-nshzkmkh.ap-northeast-2.elasticbeanstalk.com/auth/email-check"
              
              guard let url = URL(string: baseURLString) else {
                  print("Invalid URL")
                  return
              }
           // [http 요청 헤더 지정]
           let header : HTTPHeaders = [
               "Content-Type" : "application/json"
           ]
           
           // [http 요청 파라미터 지정 실시]
           let queryString : Parameters = [
            "email" : email
           ]
           
        
           // [http 요청 수행 실시]
           print("주 소 :: ", url)
           print("데이터 :: ", queryString.description)
           
           AF.request(
               url, // [주소]
               method: .post, // [전송 타입]
               parameters: queryString, // [전송 데이터]
//               encoding: URLEncoding.queryString, // [인코딩 스타일]
               encoding: JSONEncoding.default,
               headers: header // [헤더 지정]
           )
           .validate(statusCode: 200..<300)
           .responseData() { response in
               switch response.result {
               case .success(_):
                   do {
                       print("")
                       print("====================================")
                       //                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                       print("-------------------------------")
                       print("응답 코드 :: ", response.response?.statusCode ?? 0)
                       print("-------------------------------")
                       
                       
                   }
                   catch (let err){
                       print("")
                       print("====================================")
                       print("-------------------------------")
                       print("catch :: ", err.localizedDescription)
                       print("====================================")
                       print("")
                   }
                   break
               case .failure(let err):
                   print("")
                   print("====================================")
    //               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
                   print("-------------------------------")
                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   print("에 러 :: ", err.localizedDescription)
                   
                   print("====================================")
                   print("")
                   break
               }//end switch
           }// end responseDecodable
        
    }//end
}//end of LoginAPI

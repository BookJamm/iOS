//
//  Network.swift
//  BookJam
//
//  Created by 장준모 on 11/15/23.
//

import Foundation
import RxSwift
import RxAlamofire

class Network<T:Decodable> {
    private let endpoint: String    // ex) http://bookjam-dev-env.eba-dmghj93m.ap-northeast-2.elasticbeanstalk.com/api/
    private let queue: ConcurrentDispatchQueueScheduler
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func getPlacesPlaceId(path: String, placeId: Int, last: Int) -> Observable<T> {
        // path ex) reviews
//        let fullPath = "\(endpoint)\(path)?api_key=\(APIKEY)&language=ko"
        let fullPath = "\(endpoint)places/\(placeId)/\(path)?last=\(last)"
        
        return RxAlamofire.data(.get, fullPath)
            .observeOn(queue)
//            .observe(on: queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
        
    }
}

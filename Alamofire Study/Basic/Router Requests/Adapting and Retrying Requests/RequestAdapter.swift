//
//  RequestAdapter.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 17..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class RequestAdapter1 {
    /**
     * Request Adapter로 미리 만들어둔 설정을 필요시에만 Adapter시켜서 사용
     * ex) header로 auth token을 전송해야하는 상황과 아닌 상황
     */
    class AccessTokenAdapter: RequestAdapter {
        private let accessToken: String
        
        init(accessToken: String) {
            self.accessToken = accessToken
        }
        
        func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            
            if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://httpbin.org") {
                urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            }
            
            return urlRequest
        }
    }
    
    public func request() {
        let sessionManager = Alamofire.SessionManager()
        sessionManager.adapter = AccessTokenAdapter(accessToken: "1234")

        sessionManager.request("https://httpbin.org/get")
    }
}

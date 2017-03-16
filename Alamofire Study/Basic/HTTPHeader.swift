//
//  HTTPHeader.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class HTTPHeader {
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    /**
     * request의 매개변수 headers [String:String] 타입으로
     * header 전송 가능
     */
    public func httpHeaders() {
        Alamofire.request("https://api.github.com/users", headers: headers).responseJSON { response in
            print(response)
        }
    }
    
    /**
     * URLSessionConfiguration로 header을 등록해놓고
     * Configuration을 통해 만든 SessionManager을 사용 시
     * 자동으로 header가 추가된 상태로 Request됨
     */
    public func httpHeaderConfiguration() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        
        let alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.request("https://api.github.com/users").responseJSON { response in
            print(response.request?.allHTTPHeaderFields ?? "Default")
        }
    }
}

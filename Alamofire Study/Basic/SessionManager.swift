//
//  SessionManager.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class SessionManager {
    /**
     * Alamofire.request는 기본 URLSessionConfiguration으로 구성된 
     * Alamofire.SessionManager의 기본 인스턴스를 사용함
     */
    public func basicSessionManager() {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request("https://httpbin.org/get")
    }
}

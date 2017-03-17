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
    
    
    public func creatingASessionManagerWithDefaultConfiguration() {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.request("https://httpbin.org/get")
    }
    
    public func creatingASessionManagerWithBackgroundConfiguration() {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.example.app.background")
        let sessionMaanger = Alamofire.SessionManager(configuration: configuration)
        sessionMaanger.request("https://httpbin.org/get")
    }
    
    public func creatingASessionManagerWithEphemeralConfiguration() {
        let configuration = URLSessionConfiguration.ephemeral
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.request("https://httpbin.org/get")
    }
    
    public func modifyingTheSessionConfiguration() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["DNT"] = "1 (Do Not Track Enabled)"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.request("https://httpbin.org/get")
    }
    
}

//
//  Authentication.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class Authentication {
    let user = "user"
    let password = "password"
    
    /**
     * Request후 추가적인 인증이 필요한 경우 자동으로 설정된 값으로 인증을 해주는 기능
     * URLCredential
     * URLAuthenticationChallenge
     */
    public func httpBasicAuthentication() {
        /**
         * 로그인 인증을 바로 수행해줌
         */
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(user: user, password: password)
            .responseJSON { response in
                print(response)
        }
        
        
        
    }
    
    /**
     * Header의 값으로 Authorization을 해야할 경우 사용됨
     * Request.authorizationHeader로 key, value를 만들어 header에 넣어 요청
     */
    public func authorizationHeader() {
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("https://httpbin.org/basic-auth/user/password", headers: headers)
            .responseJSON { response in
                print(response)
        }
    }
    
    /**
     * 인증에 URLCredential을 사용하는 경우, 서버가 챌린지를 발행하면 기본 URLSession이 실제로 두 가지 요청을 처리하게됩니다.
     * 첫 번째 요청에는 서버에서 챌린지를 트리거 할 수있는 자격 증명이 포함되지 않습니다.
     * 그런 다음 Alamofire에서 요청을 받으면 자격 증명이 추가되고 기본 URLSession에서 요청을 다시 시도합니다.
     */
    public func authorizationCredential() {
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(usingCredential: credential)
            .responseJSON { response in
                print(response)
        }
    }
}

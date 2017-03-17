//
//  ResponseMapping.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 17..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class ResponseMapping {
    public func request() {
        /**
         * DataResponse<Any> -> DataResponse<User>
         */
        Alamofire.request("https://example.com/users/mattt").responseJSON { (response : DataResponse<Any>) in
            let userResponse = response.map { json in
                return User(json: json)
            }
            
            if let user = userResponse.value {
                print("User: { username: \(user.username), name: \(user.name)}")
            }
        }
        
        loadUser { response in
            if let user = response.value {
                print("User: { username: \(user.username), name: \(user.name) }")
            }
        }
    }
    
    @discardableResult
    func loadUser(completionHandler: @escaping (DataResponse<User>) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("https://example.com/users/mattt").responseJSON { response in
            let userResponse = response.flatMap { json in
                return User(json: json)
            }
            
            completionHandler(userResponse)
        }
    }
    
    
    
    
    
    struct User {
        var username: String
        var name: String
        
        init(json: Any) {
            username = "KDH"
            name = "dong hyuk"
        }
    }
}

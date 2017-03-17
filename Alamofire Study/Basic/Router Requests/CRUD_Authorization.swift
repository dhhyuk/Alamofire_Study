//
//  CRUD_Authorization.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 17..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

/**
 * Create, Read, Update, Delete를 처리할 때 사용 될 수 있는 예제
 */
class CRUD_Authorization {
    /**
     * Case에 따라서 설정을 한 뒤
     * URLRequest에 적용
     */
    enum Router: URLRequestConvertible {
        case createUser(parameters: Parameters)
        case readUser(username: String)
        case updateUser(username: String, parameters: Parameters)
        case destroyUser(username: String)
        
        static let baseURLString = "https://example.com"
        
        var method: HTTPMethod {
            switch self {
            case .createUser:
                return .post
            case .readUser:
                return .get
            case .updateUser:
                return .put
            case .destroyUser:
                return .delete
            }
        }
        
        var path: String {
            switch self {
            case .createUser:
                return "/users"
            case .readUser(let username):
                return "/users/\(username)"
            case .updateUser(let username, _):
                return "/users/\(username)"
            case .destroyUser(let username):
                return "/users/\(username)"
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case .createUser(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            case .updateUser(_, let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            default:
                break
            }
            
            return urlRequest
        }
    }
    
    public func request() {
        _ = Alamofire.request(Router.readUser(username: "mattt"))
        //GET https://example.com/users/mattt
    }
}

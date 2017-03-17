//
//  Request.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 17..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

/**
 Request시 사용 될 수 있는 여러가지 방법들
 */
class Request {
    
    /**
     * Request시 사용 되는 URLConvertible에 대한 여러가지 방법들
     */
    public func urlConvertible() {
        let urlString = "https://httpbin.org/post"
        _ = Alamofire.request(urlString, method: .post)
        
        let url = URL(string: urlString)!
        _ = Alamofire.request(url, method: .post)
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        _ = Alamofire.request(urlComponents, method: .post)
    }
    
    /**
     * class나 struct에 URLConvertible를 상속시켜서 asURL함수를 구현해
     * Alamofire.request()에 바로 넣어서 사용
     */
    public func typeSafeRouting() {
        let user = User(username: "mattt")
        _ = Alamofire.request(user)
    }

    /**
     * URLRequest에 설정을 다 한 뒤,
     * URLRequest만 넣을 수도 있음
     */
    public func urlRequestConvertible() {
        let url = URL(string: "https://httpbin.org/post")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parameters = ["foo": "bar"]
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        _ = Alamofire.request(urlRequest)
    }
    
    /**
     * API 형태에 Request할 때 사용하면 편할 방법
     * request형태와 데이터타입에 따라서 API 호출을 다르게 할 수 있음
     */
    //Important
    public func apiParameterAbstraction() {
        enum Router: URLRequestConvertible {
            case search(query: String, page: Int)
            
            static let baseURLString = "https://example.com"
            static let perPage = 50
            
            func asURLRequest() throws -> URLRequest {
                let result: (path: String, parameters: Parameters) = {
                    switch self {
                    case let .search(query, page) where page > 0:
                        return ("/search", ["q": query, "offset": Router.perPage * page])
                    case let .search(query, _):
                        return ("/search", ["q": query])
                    }
                }()
                
                let url = try Router.baseURLString.asURL()
                let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
                
                return try URLEncoding.default.encode(urlRequest, with: result.parameters)
            }
        }
        
        _ = Alamofire.request(Router.search(query: "foo_bar", page: 1))
        //https://example.com/search?q=foo_bar&offset=1
    }
}

struct User {
    var username: String
}

extension User: URLConvertible {
    static let baseURLString = "https://example.com"
    
    func asURL() throws -> URL {
        let urlString = User.baseURLString + "/users/\(username)"
        return try urlString.asURL()
    }
}

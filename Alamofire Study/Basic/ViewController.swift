//
//  ViewController.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 15..
//  Copyright © 2017년 KongTech. All rights reserved.
//
//  Alamofire Github의 내용들을 따라 가며 공부하기 위한 프로젝트이며
//  Alamofire부터 관련 다른 Library들을 함께 익히기 위한 프로젝트
//  Github URL  : https://github.com/sss989870/Alamofire_Study
//  Alamofire   : https://github.com/Alamofire/Alamofire
//



import UIKit
import Alamofire

class ViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpHeaders()
    }
    
    /**
     * Making a Request
     * Method : GET
     * URL로 Request를 하며 Response에 대한 아무런 처리를 하지 않음
     */
    private func makingARequest() {
        _ = Alamofire.request("https://api.github.com/users")
    }
    
    /**
     * Response Handling
     * Method : GET
     * URL로 Request를 하며 .resonseJSON을 통해서
     * request의 결과를 Cluster에서 Any 데이터 타입으로 가져오며
     * response.request = 요청정보
     * response.response = 응답정보
     * response.data = 응답 데이터
     * response.result = 응답 결과
     * 를 출력하며 response.result.value로 응답받은 값들을 받아 print
     */
    private func responseHandling() {
        /**
         * responseJSON 말고도 여러가지의 형태가 존재함
         * reponse = Default
         * responseJSON = Any
         * responseData = Data
         * responseString = String
         * responsePropertyList = plist Any
         */
        Alamofire.request("https://api.github.com/users").responseJSON { response in
            print(response.request!)
            print(response.response!)
            print(response.data!)
            print(response.result)
            
            if let JSON = response.result.value {   //response.result.value가 Nil이 아닐 시
                print("JSON: \(JSON)")
            }
        }
        //.responseJson{}.responseString{} 등의 형태로 사용가능
        
        
        /**
         * Response Handler Queue
         * 
         * utilityQueue : Background에서 실행되는 Queue(Thread)
         * response의 Queue를 설정해서 응답을 실행시킬 Queue를 정할 수 있음
         */
        let utilityQueue = DispatchQueue.global(qos: .utility)
        Alamofire.request("https://api.github.com/users")
            .response(queue: utilityQueue, responseSerializer: DataRequest.jsonResponseSerializer())
            { response in
                print(response)
        }
    }
    
    /**
     * Response Validation
     * 
     * Alamofire에서는 응답 내용에 상관 없이 무조건 SUCCESS로 다룸
     * 그러기 때문에 응답에 대해 Handle하기 전에 validate로 조건을 만들어서
     * 미리 걸러 주는 기능
     */
    private func ResponseValidation() {
        /**
         * Manual Validation
         *
         * request하고 response를 받기전에
         * statusCode가 200~299사이이며, 
         * contentType이 ["application/json"]이면 응답을 받아서 처리함
         */
        Alamofire.request("https://api.github.com/users")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
        }
        
        /**
         * Automatic Validation
         *
         * validation()은 자동적으로
         * status code가 200~299 사이이며,
         * Header의 Content-Type와 Accept가 일치해야만 응답이 실행 되게 하는 기능
         */
        Alamofire.request("https://api.github.com/users")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    /**
     * HTTP Methods : RFC 7231
     */
    public enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    /**
     * Alamofire은 원하는 Paramter들을 Encoding후 보내는 것이아니라,
     * Paramter들과 Encoding을 넘기면
     * 자동으로 변환해서 요청함
     * (Encoding 커스텀 가능)
     */
    private func jsonEncoding() {
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        /**
         * POST형식으로 paramters을 JSONEncoding으로 변환해서 요청
         * GET형식으로는 HttpBody를 보낼 수 없으므로 JSONEncoding이 되지 않음
         */
        Alamofire.request("https://api.github.com/user", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(String(data: (response.request?.httpBody)!, encoding: .utf8)!)
            //{"bar":{"baz":"qux"},"foo":[1,2,3]}
        }
    }
    
    /**
     * request의 매개변수 headers [String:String] 타입으로
     * header 전송 가능
     */
    private func httpHeaders() {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://api.github.com/users", headers: headers).responseJSON { response in
            print(response)
        }
        
        
        /**
         * URLSessionConfiguration로 header을 등록해놓고
         * Configuration을 통해 만든 SessionManager을 사용 시 
         * 자동으로 header가 추가된 상태로 Request됨
         */
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        
        let alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.request("https://api.github.com/users").responseJSON { response in
            print(response.request?.allHTTPHeaderFields ?? "Default")
        }
    }
}


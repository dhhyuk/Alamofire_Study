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
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}


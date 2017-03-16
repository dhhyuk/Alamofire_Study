//
//  Encoding.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class Encoding {
    /**
     * Alamofire은 원하는 Paramter들을 Encoding후 보내는 것이아니라,
     * Paramter들과 Encoding을 넘기면
     * 자동으로 변환해서 요청함
     * (Encoding 커스텀 가능)
     */
    public func jsonEncoding() {
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
}

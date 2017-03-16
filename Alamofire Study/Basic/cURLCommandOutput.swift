//
//  cURLCommandOutput.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class cURLCommandOutput {
    public func CustomStringConvertible() {
        let request = Alamofire.request("https://httpbin.org/ip")
        
        print(request)
    }
    
    public func CustomDebugStringConvertible() {
        let request = Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"])
        
        print(request)
    }
    
    
}

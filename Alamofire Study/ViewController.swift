//
//  ViewController.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 15..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://api.github.com/users", method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON : \(json)")
                    
                case .failure(let error):
                    print(error)
                }
        }
        
        
    }
}


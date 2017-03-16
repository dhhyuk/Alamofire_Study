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
        
        StatisticalMetrics().urlSessionTaskMetrics()
    }
}


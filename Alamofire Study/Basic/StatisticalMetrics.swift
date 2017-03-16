//
//  StatisticalMetrics.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class StatisticalMetrics {
    
    /**
     * Request요청에 대한 시간정보들을 가져옴
     */
    public func timeLine() {
        Alamofire.request("https://httpbin.org/get").responseJSON { (response) in
            print(response.timeline)
            //Timeline: { "Latency": 1.152 secs, "Request Duration": 1.157 secs, "Serialization Duration": 0.003 secs, "Total Duration": 1.160 secs }
        }
    }
    
    /**
     * TimeLine정보보다 더 많은 통계학 정보를 줌
     * iOS와 tvOS 10보다 macOS는 10.12 보다 커야함 
     */
    public func urlSessionTaskMetrics() {
        Alamofire.request("https://httpbin.org/get").responseJSON { (response) in
            print(response.metrics ?? "nil")
        }
    }
}

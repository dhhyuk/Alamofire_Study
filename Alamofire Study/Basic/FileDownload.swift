//
//  FileDownload.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class FileDownload {
    /**
     * 파일을 다운로드 하는 Request
     * responseData로 응답을 받아서 Data를 원하는 형태에 맞게 File로 변환시킴
     */
    public func downLoadingDataToAFile() {
        /**
         * Download는 Alamofire.request가 아닌 Alamofire.download로 해서
         * responseData로 data로 받음
         */
        Alamofire.download("https://httpbin.org/image/png")
            .responseData { response in
                if let data = response.result.value {
                    _ = UIImage(data: data)
                }
        }
        
        
        
    }
    
    /**
     * 파일을 다운로드할 때 옵션을 설정(파일 위치, 저장 방법등)을 해두고 Request에 옵션을 함께 설정하면
     * 설정된 대로 파일을 다운 받고 작업을 함
     */
    public func downloadingDestination(){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("pig.png")
            
            return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download("https://httpbin.org/image/png", to: destination).response { response in
            print(response)
            
            if response.error == nil, let imagePath = response.destinationURL?.path {
                _ = UIImage(contentsOfFile: imagePath)
            }
        }
    }
    
    /**
     * 파일을 다운로드할 때 다운로드된 상태를 볼 수 있음
     */
    public func downloadingProgress() {
        Alamofire.download("https://httpbin.org/image.png")
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    _ = UIImage(data: data)
                }
        }
    }
    
    /**
     * DownloadProgress를 실행 시키는 Dispatch를 만들어서 적용시킬 수 있음
     */
    public func downloadingDispatch() {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        Alamofire.download("https://httpbin.org/image/png")
            .downloadProgress(queue: utilityQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    _ = UIImage(data: data)
                }
        }
    }
    
    
    /**
     * Resuming a Download
     * 파일을 다운로드 중에 취소가 됬을 때
     * 취소된 그 부분까지의 데이터를 받는 기능
     */
    class ImageRequestor {
        private var resumeData: Data?
        private var image: UIImage?
        
        func fetchImage(completion: (UIImage?) -> Void) {
            guard image == nil else { completion(image); return }
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                documentsURL.appendPathComponent("pig.png")
                
                return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            let request: DownloadRequest
            
            if let resumeData = resumeData {
                request = Alamofire.download(resumingWith: resumeData)
            } else {
                request = Alamofire.download("https://httpbin.org/image/png")
            }
            
            request.responseData { response in
                switch response.result {
                case .success(let data):
                    self.image = UIImage(data: data)
                case .failure:
                    self.resumeData = response.resumeData
                }
            }
        }
    }
}

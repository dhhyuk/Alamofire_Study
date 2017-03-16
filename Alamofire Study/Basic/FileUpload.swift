//
//  FileUpload.swift
//  Alamofire Study
//
//  Created by 김동혁 on 2017. 3. 16..
//  Copyright © 2017년 KongTech. All rights reserved.
//

import Foundation
import Alamofire

class FileUpload {
    
    /**
     * 업로드는 Alamofire.request가 아닌, Alamofire.upload로 실행됨
     *
     * UIImagePNGRepresentation을 통해서 UIImage를 Data형태로 만들고
     * Alamofire.upload로 data를 전송
     */
    public func uploadingData() {
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: <#T##String#>))!
        
        Alamofire.upload(imageData, to: "https://httpbin.org/post").responseJSON { response in
            print(response)
        }
    }
    
    /**
     * Project내의 파일을 URL로 찾아서
     * Alamofire.upload를 URL타입으로 업로드
     */
    public func uploadingFile() {
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")
        
        Alamofire.upload(fileURL!, to: "https://httpbin.org/post")
            .responseJSON { response in
            print(response)
        }
    }
    
    /**
     * Multipart로 Request
     * 여러개의 파일을 Upload
     */
    public func uploadingMultipartFromData() {
        let fileURL1 = Bundle.main.url(forResource: "video", withExtension: "mov")
        let fileURL2 = Bundle.main.url(forResource: "video", withExtension: "mov")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(fileURL1!, withName: "video1")
                multipartFormData.append(fileURL2!, withName: "video2")
            },
            to: "https://httpbin.org/post") { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
    }
    
    /**
     * uploadProgress를 통해서 Upload 상태를 볼 수 있음
     */
    public func uploadProgress() {
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")!
        
        Alamofire.upload(fileURL, to: "https://httpbin.org/post")
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                print(response)
            }
    }
}

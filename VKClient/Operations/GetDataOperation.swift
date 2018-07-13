//
//  GetDataOperation.swift
//  nsoperation-class
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseError: Error {
    case statusCodeError
    case noInternerConnectionError
}

class GetDataOperation: AsyncOperation {
    
    override var name: String? { get { return "GetDataOperation" } set { } }
    
    private var request: DataRequest
    
    var data: Data?
    
    var error: Error? = nil
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        
        // check internet connection
        guard NetworkReachabilityManager()!.isReachable else {
            error = ResponseError.noInternerConnectionError
            cancel()
            return
        }
        
        // make request with alamofire
        request.responseData(queue: .global()) { [weak self] (response) in
            
            guard response.result.isSuccess else {
                self?.error = response.error
                self?.cancel()
                return
            }
            
            guard response.error == nil else {
                self?.error = response.error!
                self?.cancel()
                return
            }
            guard response.response?.statusCode == 200 else {
                self?.error = ResponseError.statusCodeError
                self?.cancel()
                return
            }
            
            
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(_ request: DataRequest) {
        self.request = request
    }
}

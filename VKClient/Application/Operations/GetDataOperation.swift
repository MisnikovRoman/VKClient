//
//  GetDataOperation.swift
//  nsoperation-class
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    
    override var name: String? { get { return "GetDataOperation" } set { } }
    
    private var request: DataRequest
    
    var data: Data?
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        
        // check internet connection
        guard NetworkReachabilityManager()!.isReachable else {
            cancel(with: InternetError.ConnectionError)
            return
        }
        
        // make request with alamofire
        request.responseData(queue: .global()) { [weak self] (response) in
            
            guard response.result.isSuccess else {
                guard let error = response.error else { return }
                self?.cancel(with: error)
                return
            }
            
            guard response.error == nil else {
                self?.cancel(with: response.error!)
                return
            }
            guard response.response?.statusCode == 200 else {
                guard let receivedCode = response.response?.statusCode else { return }
                let error = InternetError.StatusCodeError(receivedCode: receivedCode)
                self?.cancel(with: error)
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

//
//  ParseData.swift
//  nsoperation-class
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class ParseDataOperation<T: Decodable>: AsyncOperation {
    
    override var name: String? { get { return "GetDataOperation" } set { } }
    
    var outputData: T?
    
    override func main() {
        // get object of previous operation (load data operation)
        guard let getDataOperation = dependencies.first as? GetDataOperation else {
            cancel(with: InternetError.ParseError)
            return
        }
        // get loaded data
        guard let data = getDataOperation.data else {
            // cancel()
            return }
        // create decoder
        let decoder = JSONDecoder()
        // setup decoder
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        // parse data with Decodable protocol
        if let parsedError = try? decoder.decode(VKError.self, from: data) {
            // receiver VK error
            let message = "VKErrorMsg: " + parsedError.error.errorMsg
            cancel(with: InternetError.VKRequestError(receivedDescription: message))
        }
        
        guard let parsedData = try? decoder.decode(T.self, from: data) else {
            cancel(with: InternetError.ParseError)
            return
        }
        // save to class property
        self.outputData = parsedData
        // change state
        self.state = .finished
    }
}

//
//  ParseData.swift
//  nsoperation-class
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class ParseDataOperation<T: Decodable>: AsyncOperation {
    
    var outputData: [T] = []
    
    override func main() {
        // get object of previous operation (load data operation)
        guard let getDataOperation = dependencies.first as? GetDataOperation else { cancel(); return }
        // get loaded data
        guard let data = getDataOperation.data else { cancel(); return }
        // create decoder
        let decoder = JSONDecoder()
        // parse data with Decodable protocol
        guard let parsedPosts = try? decoder.decode([T].self, from: data) else { cancel(); return }
        // save to class property
        self.outputData = parsedPosts
        // change state
        self.state = .finished
    }
}

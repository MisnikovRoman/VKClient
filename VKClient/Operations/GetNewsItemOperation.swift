//
//  GetNewsItemOperation.swift
//  VKClient
//
//  Created by Роман Мисников on 12.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class GetNewsItemOperation: Operation {
    
    override var name: String? { get { return "GetNewsItemOperation" } set { } }
    
    var news: [NewsItem] = []
   
    override func main() {
        
        guard let getDataOperation = dependencies.first as? ParseDataOperation<VKNewsResponse> else { cancel(); return }
        guard let vkNewsResponse = getDataOperation.outputData else { cancel(); return }
        
        for vkNewsItem in vkNewsResponse.response.items {
            let newsItem = NewsItem(with: vkNewsItem, from: vkNewsResponse)
            news.append(newsItem)
        }
    }
}

//
//  VKService.swift
//  VKClient
//
//  Created by Роман Мисников on 12.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Alamofire

class VKService {
    
    static let instance = VKService()
    
    func getNewsfeed(vc: UIViewController) {
        
        let queue = OperationQueue()
        
        // 1 - create url
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_NEWSFEED)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // DEBUG
        print("🤖", "URL:", url)
        
        // 2 - create request
        let request = Alamofire.request(url)
        
        // 3 - execute load operation
        let loadOperation = GetDataOperation(request)
        loadOperation.completionBlock = { /*print("🎈loadOperation completed")*/ }
        queue.addOperation(loadOperation)
        
        // 4 - execute parse operation
        let parseOperation = ParseDataOperation<VKNewsResponse>()
        parseOperation.completionBlock = { /*print("🎈parseOperation completed")*/ }
        parseOperation.addDependency(loadOperation)
        queue.addOperation(parseOperation)
        
        // 5 - create newsfeed items
        let getNewsOperation = GetNewsItemOperation()
        getNewsOperation.completionBlock = {
            guard let newsVC = vc as? NewsVC else { return }
            newsVC.tableViewData = getNewsOperation.news
            print(/*"🎈getNewsOperation completed"*/)
        }
        getNewsOperation.addDependency(parseOperation)
        queue.addOperation(getNewsOperation)
    }
    
}

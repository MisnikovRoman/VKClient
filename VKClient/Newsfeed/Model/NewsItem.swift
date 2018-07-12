//
//  NewsItem.swift
//  VKClient
//
//  Created by Роман Мисников on 12.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class NewsItem {
    
    let avatarImage: UIImage
    let author, body: String
    let date: String
    let likesCount, commentsCount, repostsCount, viewsCount: Int
    
    init(with item: VKNewsResponse.VKNewsResponseData.VKItem, from newsfeed: VKNewsResponse) {
        
        // 0 - avatar (main image)
        var avatarUrl: String {
            return "test"
//            let authorId = item.sourceId
//            if authorId > 0 {
//                return "⚠️ Didn't loaded user photo"
//            } else {
//                let allGroups = newsfeed.response.groups
//                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
//                return allGroups[indexOfAuthor].photo100
//            }
        }
        var avatarImage = #imageLiteral(resourceName: "avatar-man")
        // ⚠️ ADD: Image loading operation
        self.avatarImage = avatarImage
        
        // 1 - author (user name or group name)
        var authorName: String {
             return "test"
//            let authorId = item.sourceId
//            if authorId > 0 {
//                return "Unknown user"
//            } else {
//                let allGroups = newsfeed.response.groups
//                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
//                return allGroups[indexOfAuthor].name
//            }
        }
        self.author = authorName
        
        // 2 - date (in unixtime)
        // ⚠️ ADD: date to string conversion in global queue
        let unixDate = item.date
        let dateString = "15 минут назад"
        // getTimeToNow(from: date)
        self.date = dateString
        // 3 - body
        self.body = item.text
        // 4 - likes count
        self.likesCount = item.likes.count
        // 5 - comments count
        self.commentsCount = item.comments.count
        // 6 - reposts count
        self.repostsCount = item.reposts.count
        // 7 - views count
        self.viewsCount = item.views?.count ?? 0
    }
}

extension NewsItem: CustomStringConvertible {
    var description: String {
        var resStr = ""
        resStr += "Author: \(author)\n"
        resStr += "Text: \(body)\n"
        resStr += "Date: \(date)\n"
        resStr += "Avatar: \(avatarImage)\n"
        resStr += "Likes: \(likesCount), "
        resStr += "Comments: \(commentsCount), "
        resStr += "Reposts: \(repostsCount), "
        resStr += "Views: \(viewsCount)\n"
        return resStr
    }
}

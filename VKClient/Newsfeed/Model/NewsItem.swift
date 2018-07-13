//
//  NewsItem.swift
//  VKClient
//
//  Created by Роман Мисников on 12.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class NewsItem {
    
    let avatarImage: String
    let author, body: String
    let attachmentUrl: String?
    var date: Date
    let likesCount, commentsCount, repostsCount, viewsCount: Int
    
    init(with item: VKNewsResponse.VKNewsResponseData.VKItem, from newsfeed: VKNewsResponse) {
        
        // 0 - avatar (main image)
        var avatarUrl: String {
            let authorId = item.sourceId
            if authorId > 0 {
                return "⚠️ Didn't loaded user photo"
            } else {
                let allGroups = newsfeed.response.groups
                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
                return allGroups[indexOfAuthor].photo100
            }
        }
        var avatarImage = #imageLiteral(resourceName: "avatar-man")
        // ⚠️ ADD: Image loading operation
        self.avatarImage = avatarUrl
        
        // 1 - author (user name or group name)
        var authorName: String {
            let authorId = item.sourceId
            if authorId > 0 {
                return "Unknown user"
            } else {
                let allGroups = newsfeed.response.groups
                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
                return allGroups[indexOfAuthor].name
            }
        }
        self.author = authorName
        
        // 2 - date (in unixtime)
        self.date = item.date
        // 3 - body
        self.body = item.text
        // 4 - attachmet photo
        var photoAttachment: String? {
            guard let vkAttachments = item.attachments else { return nil }
            guard item.attachments?.first?.type == "photo" else { return nil }
            guard let firstAttachment = vkAttachments.first else { return nil }
            guard let sizesCnt = firstAttachment.photo?.sizes.count else { return nil }
            guard sizesCnt > 0 else { return nil }
            guard let url = firstAttachment.photo?.sizes[sizesCnt - 1].url else { return nil }
            return url
        }
        self.attachmentUrl = photoAttachment
        // 5 - likes count
        self.likesCount = item.likes.count
        // 6 - comments count
        self.commentsCount = item.comments.count
        // 7 - reposts count
        self.repostsCount = item.reposts.count
        // 8 - views count
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

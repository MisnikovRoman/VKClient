//
//  Constants.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

// closure constants
typealias loadDataComplitionHandler = (_ success: Bool)->()
//typealias NewsComplitionHandler = (VKNewsResponse)->()

// vk api constants
enum VkImagesSize: String {
    case photo50 = "photo_50"
    case photo100 = "photo_100"
    case photo200 = "photo_200"
    case photoMax = "photo_max"
    case photo400 = "photo_400_orig"
    case photoMaxOriginal = "photo_max_orig"
}

// segues constants
let LOGIN_SEGUE = "RootToLogin"
let MAIN_SEGUE = "RootToMain"
let UNWIND_TO_ROOT = "UnwindToRoot"
//let TABBAR_SEGUE = "TabBarSegue"
//let UNWIND_TO_LOGIN = "BackToLoginVC"
//let UNWIND_TO_GROUPES = "BackToGroups"
//let PHOTOS_SEGUE = "ToFriendPhotos"

// user date constants
let LOGGED_IN_KEY = "loggedIn"
let AUTH_TOKEN = "authToken"

// storyboard constants
let STORYBOARD_TABBARCONTROLLER = "TabBarController"
let STORYBOARD_LOGGEDIN = "LoginVC"

// cell constants
let CELL_FRIEND = "FriendCellIdentifier"
let CELL_FRIEND_2 = "Friend2CellIdentifier"
let CELL_GROUP = "GroupCellIdentifier"
let CELL_SEARCH_GROUP = "SearchGroupCell"
let CELL_NEWS = "NewsCell"

// News cell constants
struct NEWSCONST {
    // insets constants
    static let cellInset: CGFloat = 4.0
    static let insets: CGFloat = 16.0
    static let titleToDateInset: CGFloat = 0.0
    static let iconsInset: CGFloat = 8.0
    // images size (w and h)
    static let avatarSize: CGFloat = 60.0
    static let iconSize: CGFloat = 25.0
    static let titleHeight: CGFloat = 24.0
    static let pictureHeight: CGFloat = 200.0
    // font constants
    static let titleFont = UIFont.systemFont(ofSize: 17.0, weight: .medium)
    static let dateFont = UIFont.systemFont(ofSize: 14.0, weight: .light)
    static let bodyFont = UIFont.systemFont(ofSize: 14.0)
}

// url constants
let URL_VK_AUTH = "https://oauth.vk.com/authorize"      // url to authentification page
let URL_VK_REDIRECT = "https://oauth.vk.com/blank.html" // where to go after authentification
let URL_VK_API_BASE = "https://api.vk.com/method"

// url parts constants
let VK_GET_FRIENDS = "/friends.get"
let VK_GET_GROUPS = "/groups.get"
let VK_SEARCH_GROUPS = "/groups.search"
let VK_GET_USERS = "/users.get"
let VK_GET_PHOTOS = "/photos.get"
let VK_GET_NEWSFEED = "/newsfeed.get"

// Realm data base constants
let USER_GROUP = "user_group"
let SEARCH_GROUP = "search_group"

// other constants
let CLIENT_ID = "6491638"   // VK app identification number
let APP_SCOPE = "270342"    // Битовая маска настроек доступа приложения (https://vk.com/dev/permissions)

// layout constants
let INSETS_CONSTANT = 16.0

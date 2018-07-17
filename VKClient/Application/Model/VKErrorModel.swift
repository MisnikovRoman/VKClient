//
//  VKErrorModel.swift
//  VKClient
//
//  Created by Роман Мисников on 17.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

struct VKError: Decodable {
    let error: VKErrorResponse
}

struct VKErrorResponse: Decodable {
    let errorCode: Int
    let errorMsg: String
    let requestParams: [RequestParam]
}

struct RequestParam: Decodable {
    let key, value: String
}

//
//  InternetError.swift
//  InterneError
//
//  Created by Роман Мисников on 16.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

enum InternetError: Error {
    case ConnectionError
    case HTTPResponseError
    case StatusCodeError(receivedCode: Int)
    case NoDataError
    case ParseError
    case GetReceivedDataError
    case VKRequestError(receivedDescription: String)
    
    // copy of error description
    var localizedDescription: String {
        return self.errorDescription ?? "\(self)"
    }
    
}

extension InternetError: LocalizedError {
    /// A localized message describing what error occurred.

    var errorDescription: String? {
        switch self {
        case .ConnectionError: return "Отсутствует соединение с интернетом"
        case .HTTPResponseError: return "Отсутствует HTTP ответ от сервера"
        case .StatusCodeError: return "Ошибка кода состояния HTTP"
        case .NoDataError: return "Данные не были получены"
        case .ParseError: return "Невозможно распарсить данные от сервера"
        case .GetReceivedDataError: return "Невозможно получить данные после выполнения операции загрузки"
        case .VKRequestError(let description): return description
        }
    }

    /// A localized message describing the reason for the failure.
    var failureReason: String? {
        switch self {
        case .ConnectionError: return "Невозможно соединиться с сервером"
        case .HTTPResponseError: return "Невозможно получить ответ в виде HTTP"
        case .StatusCodeError(let receivedCode): return "Полученный код равен \(receivedCode)"
        case .NoDataError: return "Отсутствуют данные в полученном ответе от сервера"
        case .ParseError: return "Данные полученные от сервера имеют разные поля с моделью данных"
        case .GetReceivedDataError: return "Операция GetDataOperation закончилась неудачно"
        case .VKRequestError/*(let description)*/: return "aa"
        }
    }

    /// A localized message describing how one might recover from the failure.
    var recoverySuggestion: String? {
        switch self {
        case .ConnectionError: return "Проверьте включен ли Wi-FI / Сотовая сеть передачи данных и баланс на счету"
        case .HTTPResponseError: return "Проверьте вид запроса и введеный URL"
        case .StatusCodeError: return "Проверьте введеный URL"
        case .NoDataError: return "Проверьте введеный URL"
        case .ParseError: return "Проверьте модель данных"
        case .GetReceivedDataError: return "Проверьте предыдущие этапы"
        case .VKRequestError: return nil
        }
    }

    /// A localized message providing "help" text if the user requests help.
    var helpAnchor: String? {
        switch self {
        case .ConnectionError: return nil
        case .HTTPResponseError: return nil
        case .StatusCodeError: return nil
        case .NoDataError: return nil
        case .ParseError: return nil
        case .GetReceivedDataError: return nil
        case .VKRequestError: return nil
        }
    }
}

extension InternetError: CustomStringConvertible {
    var description: String {
        return "❌ Внимание! Произошла ошибка:\nОписание: \(self.errorDescription ?? "")\nПричина: \(self.failureReason ?? "" )\nЧто можно сделать: \(self.recoverySuggestion ?? "")"
    }
}

extension Error {
    func notify() {
        let description = self.localizedDescription
        let userInfo: [String: String] = ["description": description]
        let notification = Notification(name: .init("InternetError"), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
}


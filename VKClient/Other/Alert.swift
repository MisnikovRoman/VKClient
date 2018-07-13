//
//  Alert.swift
//  VKClient
//
//  Created by Роман Мисников on 12.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class Alert {
    static func simpleErrorAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .cancel, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}



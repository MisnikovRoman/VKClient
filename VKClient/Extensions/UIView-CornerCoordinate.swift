//
//  UIView-CornerCoordinate.swift
//  VKClient
//
//  Created by Роман Мисников on 11.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

// Координаты четырех углов UIView
extension UIView {
    
    var upLeftCorner: CGPoint {
        return self.frame.origin
    }
    
    var upRightCorner: CGPoint {
        let y = self.frame.origin.y
        let x = self.frame.origin.x + self.frame.size.width
        return CGPoint(x: x, y: y)
    }
    
    var downLeftCorner: CGPoint {
        let x = self.frame.origin.x
        let y = self.frame.origin.y + self.frame.size.height
        return CGPoint(x: x, y: y)
    }
    
    var downRightCorner: CGPoint {
        let x = self.frame.origin.x + self.frame.size.width
        let y = self.frame.origin.y + self.frame.size.height
        return CGPoint(x: x, y: y)
    }
}

//
//  WhiteUIButton.swift
//  VKClient
//
//  Created by Роман Мисников on 10.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

@IBDesignable
class WhiteUIButton: UIButton {

    // to edit properties in app
    override func awakeFromNib() {
        setupView()
    }
    
    // to edit properties in interface builder
    override func prepareForInterfaceBuilder() {
        // call only in interface builder for @IBDesignable
        super.prepareForInterfaceBuilder()
        
        setupView()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }
}

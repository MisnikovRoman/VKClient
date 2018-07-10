//
//  RootVC.swift
//  VKClient
//
//  Created by Роман Мисников on 10.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class RootVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        activityIndicator.startAnimating()
        
        // login status of user
        if !UserData.instance.isLoggedIn {
            // segue to login page
            performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
            activityIndicator.stopAnimating()
            
        } else {
            // segue to main page
            performSegue(withIdentifier: MAIN_SEGUE, sender: nil)
            activityIndicator.stopAnimating()
        }
    }
    
    // Enable return from WebVC
    @IBAction func unwindToMain (_ segue: UIStoryboardSegue) { }
}

//
//  NewsVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 26.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Alamofire

class NewsVC: UIViewController {
    
    // MARK: - Table View Variables
    var tableViewData: [NewsItem] = [] {
        didSet {
            // calculate rowHeights for news
            tableViewRowsHeight = []
            let fixHeight = 5 * NEWSCONST.insets + NEWSCONST.avatarSize + NEWSCONST.iconSize
            let screenWidth = UIScreen.main.bounds.width
            for newsItem in tableViewData {
                var dynamicTextHeight: CGFloat = 0.0
                if newsItem.body != "" {
                    dynamicTextHeight = ​getLabelSize(text: newsItem.body, font: NEWSCONST.bodyFont, maxWidth: screenWidth - 2 * NEWSCONST.insets).height
                }
                let dynamicImageHeight: CGFloat = newsItem.attachmentUrl == nil ? 0.0 : NEWSCONST.pictureHeight
                let rowHeight = fixHeight + dynamicTextHeight + dynamicImageHeight
                tableViewRowsHeight.append(rowHeight)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var tableViewRowsHeight: [CGFloat] = []
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewController life cycle methods
   override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        // load news at start
        VKService.instance.getNewsfeed(vc: self)
        
        // Observe operation error messages
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "OperationError"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    // Notification Center selectors
    @objc func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let operationName = userInfo["operationName"] as? String else { return }
        guard let operationErrorDescription = userInfo["errorDescripton"] as? String else { return }
        let errorAlert = Alert.simpleErrorAlert(text: "Произошла ошибка во время выполнения операции \(operationName). \nПодробности: \(operationErrorDescription) \nДанная и все последующие операции были отменены")
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    // Class methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - @IBActions
    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        // create exit confirmation alert controller
        let alert = UIAlertController(title: "", message: "Вы уверены что хотите выйти из своей учетной записи?", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { (action) in
            UserData.instance.isLoggedIn = false
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refreshBtnTapped(_ sender: UIBarButtonItem) {
       VKService.instance.getNewsfeed(vc: self)
    }
}

// MARK: - TableView Extensions
extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowsHeight[indexPath.row]
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowsHeight[indexPath.row]
    }
}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS) as? NewsCell else { return UITableViewCell() }
        
        cell.setupCell(newsItem: tableViewData[indexPath.row], for: indexPath)
        return cell
    }
}

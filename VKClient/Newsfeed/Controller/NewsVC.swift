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
    
    // Variables
    var tableViewData: [NewsItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        // Observe operation error messages
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "OperationError"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Notification Center selectors
    @objc func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let operationName = userInfo["operationName"] as? String else { return }
        let errorAlert = Alert.simpleErrorAlert(text: "Произошла ошибка во время выполнения операции \(operationName). Данная и все последующие операции были отменены")
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    // Class methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // @IBActions
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

extension NewsVC: UITableViewDelegate {
    
}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS) as? NewsCell else { return UITableViewCell() }
        
        // setup image
        if let pictureUrl = tableViewData[indexPath.row].attachmentUrl {
            let queue = OperationQueue()
            let getCacheImage = GetCacheImageOperation(url: pictureUrl)
            let setImageToRowOperation = SetImageToRowOperation(cell: cell, indexPath: indexPath, tableView: tableView)
            setImageToRowOperation.addDependency(getCacheImage)
            queue.addOperation(getCacheImage)
            OperationQueue.main.addOperation(setImageToRowOperation)
        }
        
        cell.setupCell(newsItem: tableViewData[indexPath.row], for: indexPath)
        return cell
    }
}

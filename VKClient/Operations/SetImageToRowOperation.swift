//
//  SetImageToRowOperation.swift
//  VKClient
//
//  Created by Роман Мисников on 13.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class SetImageToRowOperation: Operation {
    
    override var name: String? { get { return "SetImageToRow" } set { } }
    
    private let indexPath: IndexPath
    private weak var tableView: UITableView?
    private var cell: NewsCell?
    
    init(cell: NewsCell, indexPath: IndexPath, tableView: UITableView) {
        self.indexPath = indexPath
        self.tableView = tableView
        self.cell = cell
    }
    
    override func main() {
        guard let tableView = tableView,
            let cell = cell,
            let getCacheImage = dependencies[0] as? GetCacheImageOperation,
            let image = getCacheImage.outputImage else { return }
        
//        if let newIndexPath = tableView.indexPath(for: cell), newIndexPath == indexPath {
//            cell.pictureImageView.image = image
//
//        } else { //else if tableView.indexPath(for: cell) == nil {
//            //cell.pictureImageView.image = image
//            print("image out of range")
//        }
        
        guard let newCell = tableView.cellForRow(at: indexPath) as? NewsCell else { return }
        newCell.pictureImageView.image = image
    }
}

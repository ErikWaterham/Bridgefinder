//
//  TableViewController.swift
//  Bridges
//
//  Created by Thijs Lucassen on 20-10-16.
//  Copyright © 2016 TL. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, DataSourceListViewDelegate {
    let d = D() // debugger functionality

    
    func bridgesDidChange () {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                (segue.destination as! DetailViewController).currentBridge = DataSource.sharedInstance.getBridge(index: row)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bridge                 = DataSource.sharedInstance.getBridge(index: indexPath.row)
        let cell                   = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! BridgeObjectCellTableViewCell
        cell.nameCell?.text        = bridge.name
        cell.distanceCell?.text = String(format: "%.f KM", bridge.distance!)
        cell.imageCell.image       = DataSource.sharedInstance.getImageObject(name: bridge.image)?.photo.resizedImageWithinRect(rectSize: CGSize(width: 150, height: 150))
        cell.nameCell.font = UIFont(name: "Futura", size: 19)
        cell.distanceCell.font = UIFont(name: "Futura", size: 18)
//        cell.descriptionCell.font = UIFont(name: "Futura", size: 12)
//        cell.locationCell.font = UIFont(name: "Futura", size: 12)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            d.c(s: "ListViewController - tableView - UITableViewCellEditingStyle - delete - start")
            let bridge = DataSource.sharedInstance.getBridge(index: indexPath.row)
            d.c(s: "ListViewController - tableView - UITableViewCellEditingStyle - delete - getBridge OK")
            DataSource.sharedInstance.removeBridge(bridge: bridge)
            d.c(s: "ListViewController - tableView - UITableViewCellEditingStyle - delete - removeBridge OK")
//            DataSource.sharedInstance.removeBridge(bridge: DataSource.sharedInstance.getBridge(index: indexPath.row))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.sharedInstance.countBridge()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataSource.sharedInstance.delegateListView     = self
        tableView.rowHeight                            = 100
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.reloadData()
    }
    

}


//
//  ViewController.swift
//  Remember2Remember
//
//  Created by Chris Boshoff on 2022/05/10.
//

import UIKit

class ItemViewController: UITableViewController {
  
    // MARK: - Initializers
    @IBOutlet var itemsTableView: UITableView!
    
    var itemsArray = [Item]()
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        if segue.identifier == "UpdateItem" {
            vc.update = true
            vc.item = itemsArray[(itemsArray.count-1) - ((tableView.indexPathForSelectedRow)!.row)]
        }
    }

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate   = self
        itemsTableView.dataSource = self
        
        itemsTableView.layer.borderColor  = itemsTableView.separatorColor?.cgColor
        itemsTableView.layer.borderWidth  = 1.0
        itemsTableView.layer.cornerRadius = 6.0
    }

    override func viewWillAppear(_ animated: Bool) {
        itemsArray = CoreDataManager.functions.fetchItem()!
        self.tableView.reloadData()
    }
    
    // MARK: - TableView Delegate and Datasource Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let arrayIndexReverse = (itemsArray.count - 1) - indexPath.section
            CoreDataManager.functions.deleteItem(itemObject: itemsArray[arrayIndexReverse])
            itemsArray = CoreDataManager.functions.fetchItem()!
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arrayIndexReverse = (itemsArray.count - 1) - indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        /// Customise cell to set Title, ExpData and RemindDate
        
        cell.titleLabel.text = itemsArray[arrayIndexReverse].title
        return cell
    }
}



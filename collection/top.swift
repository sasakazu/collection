//
//  top.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/13.
//

import UIKit

class top: UITableViewController {
        
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "dlkdfdkl"
        
        tableview.delegate = self
        tableview.dataSource = self

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}

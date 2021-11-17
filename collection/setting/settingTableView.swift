//
//  settingTableView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/17.
//

import UIKit

class settingTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    @IBAction func logoutBtn(_ sender: Any) {
        
        
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

//
//  top.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/13.
//

import UIKit
import Firebase
import SwiftUI

class top: UITableViewController {
        
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var fasionImage: UIImageView!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var hobbyImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        
        print(user?.email)
        
        
        self.fasionImage.layer.cornerRadius = self.fasionImage.frame.size.width * 0.5
        self.fasionImage.clipsToBounds = true
        self.hobbyImage.layer.cornerRadius = self.hobbyImage.frame.size.width * 0.5
        self.hobbyImage.clipsToBounds = true
        
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
    
//    高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
        }

    
    
    
}

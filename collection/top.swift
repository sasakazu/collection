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
        
    
    var fasionCount:[String] = []
    
    @IBOutlet weak var tableview: UITableView!
    
//    fasion cell
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var fasion: UILabel!
    
    
    @IBOutlet weak var fasionImage: UIImageView!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var createImage: UIImageView!
    @IBOutlet weak var hobbyImage: UIImageView!
    
    
    @IBOutlet weak var settingBtn: UIBarButtonItem!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewDidLoad()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let user = Auth.auth().currentUser
        
        print(user?.email)
        
        
//        settinの画像イメージ
        settingBtn.image = UIImage(systemName: "gearshape")
        
//        画像を角丸にする
        self.fasionImage.layer.cornerRadius = self.fasionImage.frame.size.width * 0.5
        self.fasionImage.clipsToBounds = true
        self.hobbyImage.layer.cornerRadius = self.hobbyImage.frame.size.width * 0.5
        self.hobbyImage.clipsToBounds = true
        self.createImage.layer.cornerRadius = self.createImage.frame.size.width * 0.5
        self.createImage.clipsToBounds = true
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
//        ファッションの個数を取得
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user!.uid).collection("fasion").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.fasionCount = querySnapshot!.documents.compactMap { $0.data()["fasionName"] as? String }
                    
                    self.fasion.text = self.fasionCount.count.description
                    
                }
            }
        }
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
//    高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
        }

    
    
    
}

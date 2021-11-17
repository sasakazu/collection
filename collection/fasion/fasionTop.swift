//
//  fasionTop.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/14.
//

import UIKit
import Firebase

class fasionTop: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var collectionItems:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return collectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = fasionTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! fasionTableViewCell
        
        cell.textLabel?.text = collectionItems[indexPath.row]
        
        
        return cell
        
    }
    

    
    @IBOutlet weak var fasionTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fasionTable.delegate = self
        fasionTable.dataSource = self
        
//
        let nib = UINib(nibName: "fasionTableViewCell", bundle: nil)
        
        fasionTable.register(nib, forCellReuseIdentifier: "Cell")
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        
        db.collection("users").document(user!.uid).collection("fasion").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    self.collectionItems = querySnapshot!.documents.compactMap { $0.data()["collectionName"] as? String }
                    
                }
                self.fasionTable.reloadData()
            }
        }

        
        // Do any additional setup after loading the view.
    }
    

}

//
//  fasionTop.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/14.
//

import UIKit
import Firebase

class fasionTop: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myID = ""
    
    var collectionItems:[String] = []
    var documentID:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return collectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = fasionTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! fasionTableViewCell
        
        cell.textLabel?.text = collectionItems[indexPath.row]
        
        
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myID = documentID[indexPath.row]
        performSegue(withIdentifier: "sendData", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sendData" {
            if let nextVC = segue.destination as? fasionDetailView {
              
                nextVC.id = myID
            
            
        }
    }
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
                    
                    self.collectionItems = querySnapshot!.documents.compactMap { $0.data()["fasionName"] as? String }
                    self.documentID = querySnapshot!.documents.compactMap { $0.data()["documentID"] as? String }
                    
                    
                    
                }
                self.fasionTable.reloadData()
            }
        }

        
        // Do any additional setup after loading the view.
    }
    

}

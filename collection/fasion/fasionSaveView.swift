//
//  fasionSaveView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/16.
//

import UIKit
import Firebase

class fasionSaveView: UIViewController {
    
    
    var collectionname:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func saveBtn(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()

        db.collection("users").document(user!.uid).collection("fasion").document().setData([

            "collectionName": collectionname

        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
    
    
}

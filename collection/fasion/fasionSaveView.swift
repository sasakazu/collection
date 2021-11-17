//
//  fasionSaveView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/16.
//

import UIKit
import Firebase

class fasionSaveView: UIViewController {
    
    
    @IBOutlet weak var imageOne: UIImageView!
    
    
    var collectionname:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func libraryBtn(_ sender: Any) {
    
    
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
    }
    

    
    @IBAction func saveBtn(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()

        let Ref = db.collection("users").document(user!.uid).collection("fasion")
            
            let doc = Ref.document()
            
            let somedata = [ "collectionName": collectionname,
                             "documentID": doc.documentID
                            ]

        Ref.document(doc.documentID).setData(somedata) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
    
    
}

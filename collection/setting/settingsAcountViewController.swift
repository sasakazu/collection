//
//  settingsAcountViewController.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/25.
//

import UIKit
import Firebase

class settingsAcountViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                self.emailTextField.text = document["email address"] as? String ?? "no data"
                
            
          } else {
            print("Document does not exist in cache")
          }
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneBtn(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
      
        db.collection("users").document(user!.uid).setData([
            "email address": emailTextField.text as Any
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.dismiss(animated: true, completion: nil)
            }
        }

        
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}

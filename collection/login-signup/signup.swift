//
//  signup.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/14.
//

import UIKit
import Firebase
import FirebaseFirestore

class signup: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signupTapped(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: passTF.text!) { authResult, error in
        
        print("sign up!")
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        let id = user?.uid
            
        db.collection("users").document(id!).setData([
            "email": self.emailTF.text ?? "noemail",
            "userID": user?.uid ?? "nouid"
        
        ], merge: true)
        }
        
        
    }
    
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
              try firebaseAuth.signOut()
        
        } catch let signOutError as NSError {
            
            print("Error signing out: %@", signOutError)
        
        }
      
    }
    
    

}

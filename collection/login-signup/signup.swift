//
//  signup.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/14.
//

import UIKit
import Firebase

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
            
            
        }
        
        
    }
    

}

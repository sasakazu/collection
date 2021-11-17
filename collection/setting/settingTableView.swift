//
//  settingTableView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/17.
//

import UIKit
import Firebase

class settingTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    @IBAction func logoutBtn(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "ログアウト", message: "ログアウトしてもよろしいですか？", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            
            let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
            
                    let storyboard: UIStoryboard = self.storyboard!
            
                    let nextView = storyboard.instantiateViewController(withIdentifier: "login") as! login
            
                    self.present(nextView, animated: true, completion: nil)
            
                    print("logout!")
            
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        

        
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

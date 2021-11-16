//
//  fasionCreateView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/14.
//

import UIKit
import Firebase

class fasionCreateView: UIViewController {

    
    @IBOutlet weak var collectionNameTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextBtn(_ sender: Any) {
     
        
        performSegue(withIdentifier: "nextSegue", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        let next = segue.destination as? fasionSaveView
        
        let _ = next?.view
        
        next?.collectionname = collectionNameTF.text ?? "no name"
      }
    
    
}

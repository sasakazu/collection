//
//  showFasionImageView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/25.
//

import UIKit
import Firebase
import SDWebImage

class showFasionImageView: UIViewController {

    var imagedata = ""
    var collename = ""
    var imagenames = ""
    
    @IBOutlet weak var showImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImage.sd_setImage(with: URL(string:imagedata), placeholderImage: UIImage(named: "placeholder"))
        
        print("fadkfhnfgjafjk;a\(imagedata)")
        print(collename)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func trashBtn(_ sender: Any) {
    
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
//        storageの削除
       
        let desertRef = Storage.storage().reference().child("posts").child(user!.uid).child(collename).child(imagenames)
        
        desertRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // File deleted successfully
          }
        }
            
        
        //特定のフィールドの削除
        let washingtonRef = db.collection("users").document(user!.uid).collection("fasion").document(self.collename)
        
        washingtonRef.updateData([
            "images": FieldValue.arrayRemove([self.imagedata]),
            "imageNames": FieldValue.arrayRemove([self.imagenames])
        ])
        
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                
            self.navigationController?.popViewController(animated: true)

                
            }
        }
        
    }
    
}

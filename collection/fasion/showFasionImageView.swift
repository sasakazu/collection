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
    var category = ""
    
    @IBOutlet weak var showImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImage.sd_setImage(with: URL(string:imagedata), placeholderImage: UIImage(named: "placeholder"))
        
        print("fadkfhnfgjafjk;a\(imagedata)")
        print(collename)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func trashBtn(_ sender: Any) {
    
        
        let refreshAlert = UIAlertController(title: "削除", message: "本当に削除してもよろしいですか？", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "削除", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
//        storageの削除
       
            let desertRef = Storage.storage().reference().child("posts").child(user!.uid).child(self.category).child(self.collename).child(self.imagenames)
        
        desertRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // File deleted successfully
          }
        }
            
        
        //特定のフィールドの削除
            let washingtonRef = db.collection("users").document(user!.uid).collection(self.category).document(self.collename)
        
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
        
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        

        
            
            
    }
    
                                             
                                             
}

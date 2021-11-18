//
//  fasionDetailView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/17.
//

import UIKit
import Firebase
import SDWebImage

class fasionDetailView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! fasionDetailViewCell
        
        self.imageData = items[indexPath.row]
            
        cell.fasionImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
        
    }
    

    
    var id:String = ""
    var items:[String] = []
    var imageData = ""
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self

        
        let nib = UINib(nibName: "fasionDetailViewCell", bundle: nil)
        
        self.collectionview.register(nib, forCellWithReuseIdentifier: "Cell")
        
//        print(id)
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        db.collection("users").document(user!.uid).collection("fasion").whereField("documentID", isEqualTo: self.id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        
                        self.items = querySnapshot!.documents.compactMap { $0.data()["imageOne"] as? String }
                        
                        print(self.items)
                        
                    }
                    self.collectionview.reloadData()
                }

        }
        
        
        
        // Do any additional setup after loading the view.
    }
   

}

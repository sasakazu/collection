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
        
        imageData = items[indexPath.row]

        cell.fasionImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder"))

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        sendData = items[indexPath.row]
        sendImageNamePost = sendImageName[indexPath.row]
        
        performSegue(withIdentifier: "showImageView", sender: self)
//        performSegue(withIdentifier: "sendAddView", sender: self)
        
    }
    
    
    @IBAction func addView(_ sender: Any) {
        
        performSegue(withIdentifier: "sendAddView", sender: self)
    
    }
    
    //    詳細画面にデータを送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let nextVC = segue.destination as? showFasionImageView {

            nextVC.imagedata = sendData
            nextVC.collename = collectionname
            nextVC.imagenames = sendImageNamePost
            nextVC.category = collectionCategoly
            
            }
        
        else if let addVC = segue.destination as? fasionAddView {
            
            addVC.addname = collectionname
            addVC.imageItems = items
            addVC.imageNames = sendImageName
            addVC.category = collectionCategoly
            
            
        }
        
        }

    var id:String = ""
    var items:[String] = []
    var itemsName:[String] = []
    var nameitems = ""
    var imageData = ""
    var sendData = ""
    var sendName = ""
    var sendImageNamePost = ""
    var sendImageName:[String] = []
    var collectionname:String = ""
    
    var collectionCategoly = ""
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewDidLoad()
        collectionview.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self

        
        let nib = UINib(nibName: "fasionDetailViewCell", bundle: nil)
        
        self.collectionview.register(nib, forCellWithReuseIdentifier: "Cell")
        
        print(id)
        print(collectionname)
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        db.collection("users").document(user!.uid).collection(collectionCategoly).whereField("fasionName", isEqualTo: collectionname).getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
    

                    self.items = document["images"] as? [String] ?? [""]
                    self.sendImageName = document["imageNames"] as? [String] ?? [""]
                    self.sendName = collectionname


                    print("kmojhohouo\(self.items)")

                  
                }
              
            }
            
            self.collectionview.reloadData()

        }
        
        
        
        // Do any additional setup after loading the view.
    }
   

}

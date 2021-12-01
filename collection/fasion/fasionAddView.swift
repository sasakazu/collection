//
//  fasionAddView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/28.
//

import UIKit
import Firebase
import DKImagePickerController

class fasionAddView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var addname = ""
    var urls = [String]()
    var imageNames = [String]()
    var imageItems:[String] = []
    var category = ""
    
    var addPhotos: [UIImage] = []
    var selectedCount = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return addPhotos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! fasionAddCollectionViewCell
        
        cell.fasionAddimageView.image = addPhotos[indexPath.row]
             
        return cell
        
    }
    

    
    @IBOutlet weak var addCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(addname)
//        print("imagename issssss   \(imageNames)")
//        print("item isssssssss     \(imageItems)")
        
        addCollectionView.delegate = self
        addCollectionView.dataSource = self
        
        let nib = UINib(nibName: "fasionAddCollectionViewCell", bundle: nil)
        addCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func libralyBtn(_ sender: Any) {
        
        let imagePicker = DKImagePickerController()
        imagePicker.maxSelectableCount = 6

        imagePicker.sourceType = .photo

        imagePicker.showsCancelButton = true

        imagePicker.didSelectAssets = { (assets: [DKAsset]) in
               // ここでは一旦全削除する
        self.addPhotos.removeAll()

               // assets に保存された枚数
        self.selectedCount = assets.count

        for asset in assets {
                
            asset.fetchFullScreenImage(completeBlock: { (image, info) in
                       // もし image が nil だったら早期リターン
                guard let image = image else {
                    self.selectedCount -= 1
                    return
                }

                // photos に追加
                self.addPhotos.append(image)

                
                print(self.addPhotos)
                // reloadImage 内部で UITableView を操作しているため
                // メインスレッドで実行
                DispatchQueue.main.async {
                    self.reloadImage()
                }
            })
        }
    }

        // ここでDKImagePickerを表示
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func reloadImage() {
         // photos.count と asset.count が等しければ tableView を再描画
         if addPhotos.count == selectedCount {
             addCollectionView.reloadData()
         }
     }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
        let user = Auth.auth().currentUser
        
        var count = 0
        
        for image in addPhotos {

        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        let imageName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("posts").child(user!.uid).child(category).child(self.addname).child(imageName)
            
        guard let data = image.jpegData(compressionQuality: 0.1) else {return}
             storageRef.putData(data, metadata: metaData) { (metadata, error) in
                 if error != nil {
                     return
                 }
                 storageRef.downloadURL(completion: { (url, error) in
                     if let photoUrl = url?.absoluteString {
                         let url = photoUrl

                         self.imageItems.append(url)
                         
                         let db = Firestore.firestore()

                         self.imageNames.append(imageName)
                                      
                         let Ref = db.collection("users").document(user!.uid).collection(self.category)
                             
                         let aDoc = Ref.document()
                         
                         print(aDoc.documentID)
                         
                         let someData = [
                            "images": self.imageItems,
                            "imageNames": self.imageNames,
                         
                         ] as [String : Any]
                             
                         Ref.document(self.addname).updateData(someData)
                            {
                             err in
                             if let err = err {
                                 print("Error writing document: \(err)")
                                     } else {
                                         print("Document successfully written!")
                                        }
                                }
                     }
                     

                     count += 1
                     if count == self.addPhotos.count {
                         print("self.urls.count \(self.urls.count)")


                     }
                 })
             }

         }

//        self.navigationController?.popToRootViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}

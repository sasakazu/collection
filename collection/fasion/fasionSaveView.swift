//
//  fasionSaveView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/16.
//

import UIKit
import Firebase
import SwiftUI
import DKImagePickerController

class fasionSaveView: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! fasionSaveCollectionViewCell
        
        cell.imageViewSave.image = photos[indexPath.row]
             
        return cell
        
    }
    
    
    
    @IBOutlet weak var fasionCollectionView: UICollectionView!
    
    
    var postImageOne:String = ""
    var collectionname:String = ""
    
    var photos: [UIImage] = []
    var urls = [String]()
    var selectedCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fasionCollectionView.delegate = self
        fasionCollectionView.dataSource = self

        let nib = UINib(nibName: "fasionSaveCollectionViewCell", bundle: nil)
        fasionCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func libraryBtn(_ sender: Any) {
    
        
        let imagePicker = DKImagePickerController()
        imagePicker.maxSelectableCount = 6

           //カメラモード、写真モードの選択
        imagePicker.sourceType = .photo

           //キャンセルボタンの有効化
        imagePicker.showsCancelButton = true

           //UIのカスタマイズ
   //        imagePicker.UIDelegate = CustomUIDelegate()

        imagePicker.didSelectAssets = { (assets: [DKAsset]) in
               // ここでは一旦全削除する
        self.photos.removeAll()

               // assets に保存された枚数
        self.selectedCount = assets.count

        for asset in assets {
                   // asset からのダウンロードは非同期（iCloudなどにアクセスするため）
            asset.fetchFullScreenImage(completeBlock: { (image, info) in
                       // もし image が nil だったら早期リターン
                guard let image = image else {
                    self.selectedCount -= 1
                    return
                }

                       // photos に追加
                self.photos.append(image)

                
                print(self.photos)
//                    self.collection.reloadData()
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
         if photos.count == selectedCount {
             fasionCollectionView.reloadData()
         }
     }

    
    


    @IBAction func saveBtn(_ sender: Any) {
    
        let user = Auth.auth().currentUser
        
        var count = 0
        
    for image in photos {

        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        let imageName = NSUUID().uuidString // Unique string to reference image
        let storageRef = Storage.storage().reference().child("posts").child(user!.uid).child(self.collectionname).child(imageName)
            
        guard let data = image.jpegData(compressionQuality: 0.1) else {return}
             storageRef.putData(data, metadata: metaData) { (metadata, error) in
                 if error != nil {
                     return
                 }
                 storageRef.downloadURL(completion: { (url, error) in
                     if let photoUrl = url?.absoluteString {
                         let url = photoUrl

                         self.urls.append(url)
                         
                         let db = Firestore.firestore()

                                      
                         let Ref = db.collection("users").document(user!.uid).collection("fasion")
                             
                         let aDoc = Ref.document()
                         
                         print(aDoc.documentID)
                         
                         let someData = [
                            "images": self.urls,
                            "fasionName": self.collectionname,
                            "documentID":aDoc.documentID
                         ] as [String : Any]
                             
                         Ref.document(self.collectionname).setData(someData)
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
                     if count == self.photos.count {
                         print("self.urls.count \(self.urls.count)")


                     }
                 })
             }

         }

        self.navigationController?.popToRootViewController(animated: true)

    }
    
    
    
    
    
    
}

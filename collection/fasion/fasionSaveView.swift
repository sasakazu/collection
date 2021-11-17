//
//  fasionSaveView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/16.
//

import UIKit
import Firebase
import SwiftUI

class fasionSaveView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageOne: UIImageView!
    
    var postImageOne:String = ""
    var collectionname:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func libraryBtn(_ sender: Any) {
    
        let sourceType:UIImagePickerController.SourceType =
                 UIImagePickerController.SourceType.photoLibrary
             
             if UIImagePickerController.isSourceTypeAvailable(
                 UIImagePickerController.SourceType.photoLibrary){
                 // インスタンスの作成
                 let cameraPicker = UIImagePickerController()
                 cameraPicker.sourceType = sourceType
                 cameraPicker.delegate = self
                 self.present(cameraPicker, animated: true, completion: nil)
                 
//                 label.text = "Tap the [Start] to save a picture"
             }
             else{
//                 label.text = "error"
                 
             }
    
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
        let sourceType:UIImagePickerController.SourceType =
                   UIImagePickerController.SourceType.camera
               // カメラが利用可能かチェック
               if UIImagePickerController.isSourceTypeAvailable(
                   UIImagePickerController.SourceType.camera){
                   // インスタンスの作成
                   let cameraPicker = UIImagePickerController()
                   cameraPicker.sourceType = sourceType
                   cameraPicker.delegate = self
                   self.present(cameraPicker, animated: true, completion: nil)
                   
               }
               else{
                   print("error")
                   
               }
        
    }
    
    //　撮影が完了時した時に呼ばれる
      func imagePickerController(_ imagePicker: UIImagePickerController,
              didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
          
          if let pickedImage = info[.originalImage]
              as? UIImage {
              
              imageOne.contentMode = .scaleAspectFit
              imageOne.image = pickedImage
              
          }
   
          //閉じる処理
          imagePicker.dismiss(animated: true, completion: nil)
          print("Tap the [Save] to save a picture")
          
      }
      
      // 撮影がキャンセルされた時に呼ばれる
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
          print("Canceled")
      }
    
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
//            label.text = "Save Failed !"
        }
        else{
            print("Save Succeeded")
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
    
        
        let image:UIImage! = imageOne.image
        let user = Auth.auth().currentUser
        
        
        let date = NSDate()
              let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("users").child(user!.uid).child(self.collectionname).child("post1.jpg")

        
              let metaData = StorageMetadata()
              metaData.contentType = "image/jpg"
              if let uploadData = self.imageOne.image?.jpegData(compressionQuality: 0.9) {
                  storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
                      if error != nil {
                          print("error: \(error?.localizedDescription)")
                      }
                      storageRef.downloadURL(completion: { (url, error) in
                          if error != nil {
                              print("error: \(error?.localizedDescription)")
                          }
                          print("url: \(url?.absoluteString)")
                          
                          self.postImageOne = url?.absoluteString ?? "no url"
                        
                                     
                          let db = Firestore.firestore()
                          
                          let Ref = db.collection("users").document(user!.uid).collection("fasion")
                              
                          let doc = Ref.document()
                              
                          let somedata = [ "collectionName": self.collectionname,
                                            "documentID": doc.documentID,
                                           "imageOne": self.postImageOne
                                        
                          ]

                          Ref.document(doc.documentID).setData(somedata) { err in
                              
                              if let err = err {
                                  print("Error writing document: \(err)")
                              } else {
                                  print("Document successfully written!")
                              }
                          }
                                     
                          self.navigationController?.popToRootViewController(animated: true)
                             
                      })
                  }
              }
        
   

        
    }
    
    
    
    
    
}

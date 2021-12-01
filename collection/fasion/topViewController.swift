//
//  topViewController.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/30.
//

import UIKit
import Firebase

class topViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var collectionItems:[String] = []
    var sendCollection = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = topTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! topTableViewCell
        
        cell.topTextLabel.text = titleCollection[indexPath.row]
        let cellImage = UIImage(named: topImage[indexPath.row])
        cell.topImageCell.image = cellImage
        
        return cell
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sendCollection = fireCollecton[indexPath.row]
        
        
        performSegue(withIdentifier: "goMainView", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goMainView" {
            if let nextVC = segue.destination as? fasionTop {
              
                nextVC.collectionName = sendCollection
            
        }
    }
}

    var titleCollection = ["人・家族","ファッション・服","音楽・レコード","創作・趣味","その他"]
    
    var topImage = ["family","fasion","music","gundum","hobby"]
    
    var fireCollecton = ["family","fasion","music","gundum","hobby"]
    
    @IBOutlet weak var topTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTableView.delegate = self
        topTableView.dataSource = self
        
        let nib = UINib(nibName: "topTableViewCell", bundle: nil)
        
        topTableView.register(nib, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    

}

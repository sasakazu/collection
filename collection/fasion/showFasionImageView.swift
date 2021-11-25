//
//  showFasionImageView.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/25.
//

import UIKit
import SDWebImage

class showFasionImageView: UIViewController {

    var imagedata = ""
    
    @IBOutlet weak var showImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImage.sd_setImage(with: URL(string:imagedata), placeholderImage: UIImage(named: "placeholder"))
        
        print("fadkfhnfgjafjk;a\(imagedata)")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func trashBtn(_ sender: Any) {
    
    
    }
    
}

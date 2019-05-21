//
//  DetailViewController.swift
//  InstakiloSwift
//
//  Created by Dayson Dong on 2019-05-20.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage.init(named: self.imageName)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FirstViewController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 5/9/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2.5, animations: {
            self.headerLabel.alpha = 1.0
            self.bodyLabel.alpha = 1.0
        }) 
        
        UIView.animate(withDuration: 2.0, delay: 0.2, options: [.curveEaseOut], animations: {
            self.imageView.center.y = self.imageView.center.y + 120
            }, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

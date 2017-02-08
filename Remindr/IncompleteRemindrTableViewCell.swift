//
//  IncompleteRemindrTableViewCell.swift
//  Remindr
//
//  Created by Spencer Curtis on 2/8/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

import UIKit

class IncompleteRemindrTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        
        self.addGestureRecognizer(panRecognizer)
    }

    func handlePan(sender: UIPanGestureRecognizer) {
        print(sender.translation(in: self).x)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

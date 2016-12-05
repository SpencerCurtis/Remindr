//
//  RemindrTableViewCell.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/23/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit

class RemindrTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    var delegate: RemindrTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        if let delegate = delegate {
            delegate.remindrCellTapped(checkboxButton, sender: self)
        }
    }
    
    func updateButton(_ isComplete: Bool) {
        
        if isComplete == true {
            checkboxButton.setImage(UIImage(named: "checkedBox") ?? UIImage(), for: UIControlState())
        } else if isComplete == false {
            checkboxButton.setImage(UIImage(named: "uncheckedBox") ?? UIImage(), for: UIControlState())
        }
    }
    
}
protocol RemindrTableViewCellDelegate {
    func remindrCellTapped(_ checkboxButton: UIButton, sender: RemindrTableViewCell)
}


extension RemindrTableViewCell {
    func updateWithremindr(_ remindr: Remindr) {
        titleLabel.text = remindr.title
        noteLabel.text = remindr.notes
        alertLabel.text = remindr.alertLabelText
        if let isComplete = remindr.isComplete {
            updateButton(isComplete.boolValue)
        }
    }
}

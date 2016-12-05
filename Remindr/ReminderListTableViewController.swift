//
//  remindrListTableViewController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/23/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit
import CoreLocation

class remindrListTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    static let sharedController = remindrListTableViewController()
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var remindrFilterSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCount()
        
        self.tableView.tableHeaderView = searchBarView
        self.tableView.contentOffset = CGPoint(x: 0, y: 45)
        
        self.tableView.estimatedRowHeight = 58
        self.navigationController?.navigationBar.isTranslucent = true
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse  && LocationController.sharedController.remindrsUsingLocationCount > 1 {
            LocationController.sharedController.locationManager.requestLocation()
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tableView.contentOffset = CGPoint(x: 0, y: 45)
        remindrFilterSegmentedControl.selectedSegmentIndex = 0
    }
    
    func loadCount() {
        
        for _ in remindrController.sharedController.incompleteremindrsWithLocationUponArriving {
            LocationController.sharedController.increaseLocationCount()
        }
        for _ in remindrController.sharedController.incompleteremindrsWithLocationUponLeaving {
            LocationController.sharedController.increaseLocationCount()
        }
    }
    
    @IBAction func remindrFilterSegmentedControlValueChanged(_ sender: AnyObject) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnInt = 0
        if remindrFilterSegmentedControl.selectedSegmentIndex == 0 {
            returnInt = remindrController.sharedController.incompleteremindrs.count
        } else if remindrFilterSegmentedControl.selectedSegmentIndex == 1 {
            returnInt = remindrController.sharedController.completeremindrs.count
        }
        return returnInt
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindrCell", for: indexPath) as! remindrTableViewCell
        if remindrFilterSegmentedControl.selectedSegmentIndex == 0 {
            let remindr = remindrController.sharedController.incompleteremindrs[indexPath.row]
            cell.delegate = self
            cell.updateWithremindr(remindr)
            if let bool = remindr.isComplete?.boolValue {
                cell.updateButton(bool)
            }
        } else if remindrFilterSegmentedControl.selectedSegmentIndex == 1 {
            let remindr = remindrController.sharedController.completeremindrs[indexPath.row]
            cell.delegate = self
            cell.updateWithremindr(remindr)
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return remindrController.sharedController.remindrs.count > 0 ? UITableViewAutomaticDimension : 58
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let remindr = remindrController.sharedController.remindrs[indexPath.row]
            remindrController.sharedController.remove(remindr: remindr)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editremindr" {
            let dvc = segue.destination as? remindrDetailViewController
            
            if let remindrDetailViewController = dvc {
                _ = remindrDetailViewController.view
                
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    dvc?.remindr = remindrController.sharedController.remindrs[selectedRow]
                    remindrDetailViewController.updateWithremindr(remindrController.sharedController.remindrs[selectedRow])
                    dvc?.title = "Edit Remindr"
                }
            }
        }
    }
}



extension remindrListTableViewController: remindrTableViewCellDelegate {
    
    func remindrCellTapped(_ checkboxButton: UIButton, sender: remindrTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        var remindr: Remindr?
        
        if remindrFilterSegmentedControl.selectedSegmentIndex == 0 {
            remindr = remindrController.sharedController.incompleteremindrs[indexPath.row]
        } else if remindrFilterSegmentedControl.selectedSegmentIndex == 1 {
            remindr = remindrController.sharedController.completeremindrs[indexPath.row]
        }
        
        
        if checkboxButton.isSelected == false {
            DispatchQueue.main.async(execute: { () -> Void in
                if let remindr = remindr { remindr.isComplete = true }
                
                LocationController.sharedController.decreaseLocationCount()
                
                remindrController.sharedController.saveToPersistentStorage()
                if let remindr = remindr {
                    RegionController.sharedController.stopMonitoringremindr(remindr)
                    NotificationController.sharedController.removeNotificationFor(remindr: remindr)
                }
                
                self.tableView.reloadData()
                
            })
        } else if checkboxButton.isSelected == true {
            DispatchQueue.main.async(execute: { () -> Void in
                if let remindr = remindr {
                    remindr.isComplete = false
                }
                checkboxButton.isSelected = false
                remindrController.sharedController.saveToPersistentStorage()
                
                self.tableView.reloadData()
                
            })
            
        }
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
        })
        
        
    }
}

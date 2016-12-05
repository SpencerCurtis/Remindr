    //
    //  remindrDetailViewController.swift
    //  Capstoneremindr
    //
    //  Created by Spencer Curtis on 3/23/16.
    //  Copyright © 2016 Spencer Curtis. All rights reserved.
    //
    
    import UIKit
    import CoreLocation
    // FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
    // Consider refactoring the code to use the non-optional operators.
    fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l < r
        case (nil, _?):
            return true
        default:
            return false
        }
    }
    
    // FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
    // Consider refactoring the code to use the non-optional operators.
    fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l > r
        default:
            return rhs < lhs
        }
    }
    
    
    class remindrDetailViewController: UIViewController, CLLocationManagerDelegate {
        
        static let sharedController = remindrDetailViewController()
        
        @IBOutlet weak var header: UINavigationItem!
        @IBOutlet weak var saveButton: UIBarButtonItem!
        @IBOutlet weak var updatingLocationView: UIView!
        @IBOutlet weak var alertTimeDatePicker: UIDatePicker!
        @IBOutlet weak var titleTextField: UITextField!
        @IBOutlet weak var notesTextView: UITextView!
        @IBOutlet weak var alertSegmentedControl: UISegmentedControl!
        @IBOutlet weak var alertDatePicker: UIDatePicker!
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        @IBOutlet weak var atALocationLabel: UILabel!
        @IBOutlet weak var uponMovingFromLocationLabel: UILabel!
        
        
        var alertTimeValue = Date()
        var remindr: Remindr?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            notesTextView.sizeToFit()
            titleTextField.delegate = self
            if remindr != nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.title = "Edit Remindr"
                })
            }
            uponMovingFromLocationLabel.text = "You will be reminded upon moving from this location."
            LocationController.sharedController.requestAuthorization()
            
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            editTextView()
            editTextField()
            activityIndicator.stopAnimating()
            editOtherViews()
            checkIfTextFieldIsEmpty()
            setUpViewsBasedOnSegmentedControl()
            if LocationController.sharedController.selectedLocation != nil {
                alertSegmentedControl.selectedSegmentIndex = 2
                if let name = LocationController.sharedController.atALocationTextName /*, address = LocationController.sharedController.atALocationTextAddress */{
                    atALocationLabel.text = "You will be reminded upon arriving at  \(name)."
                }
            }
            
        }
        
        func setUpViewsBasedOnSegmentedControl() {
            if alertSegmentedControl.selectedSegmentIndex == 0 {
                
                alertDatePicker.isHidden = false
                uponMovingFromLocationLabel.isHidden = true
                atALocationLabel.isHidden = true
                
            } else if alertSegmentedControl.selectedSegmentIndex == 1 {
                
                alertDatePicker.isHidden = true
                atALocationLabel.isHidden = true
                uponMovingFromLocationLabel.isHidden = false
                
            } else if alertSegmentedControl.selectedSegmentIndex == 2 {
                
                alertDatePicker.isHidden = true
                uponMovingFromLocationLabel.isHidden = true
                atALocationLabel.isHidden = false
            }
        }
        
        func editOtherViews() {
            alertDatePicker.minimumDate = Date()
            addToolBar(titleTextField)
            addToolBarForTextView(notesTextView)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
            super.touchesBegan(touches, with: event)
        }
        
        @IBAction func UponMovingSegmentedControlTapped(_ sender: AnyObject) {
            if alertSegmentedControl.selectedSegmentIndex == 2 {
                // MAKE SURE THEY HAVE PERMISSION
                setUpViewsBasedOnSegmentedControl()
                LocationController.sharedController.requestAuthorization()
                LocationController.sharedController.locationManager.requestLocation()
                LocationController.sharedController.currentLocation = LocationController.sharedController.locationManager.location
                performSegue(withIdentifier: "toMapView", sender: self)
                
            } else if alertSegmentedControl.selectedSegmentIndex == 1 {
                LocationController.sharedController.requestAuthorization()
                setUpViewsBasedOnSegmentedControl()
                alertDatePicker.isHidden = true
                
            } else if alertSegmentedControl.selectedSegmentIndex == 0 {
                setUpViewsBasedOnSegmentedControl()
                LocationController.sharedController.locationManager.requestLocation()
                alertDatePicker.isHidden = false
            }
        }
        
        func editTextField() {
            self.titleTextField.layer.cornerRadius = 8
            self.titleTextField.layer.borderWidth = 0.6
            self.titleTextField.layer.borderColor = UIColor(red: 0.784, green: 0.784, blue: 0.792, alpha: 1.00).cgColor
            
        }
        func editTextView() {
            self.notesTextView.layer.cornerRadius = 8
            self.notesTextView.layer.borderWidth = 0.6
            self.notesTextView.layer.borderColor = UIColor(red: 0.784, green: 0.784, blue: 0.792, alpha: 1.00).cgColor
        }
        
        @IBAction func saveButtonTapped(_ sender: AnyObject) {
            if alertSegmentedControl.selectedSegmentIndex == 1 && LocationController.sharedController.locationManager.location == nil {
                startActivityIndicator()
                
                LocationController.sharedController.locationManager.requestLocation()
                if LocationController.sharedController.locationManager.location != nil {
                    self.stopActivityIndicator()
                    navigationController?.pop(animated: true)
                } else {
                    LocationController.sharedController.locationManager.requestLocation()
                    self.saveButtonTapped(sender)
                }
                
            } else if alertSegmentedControl.selectedSegmentIndex == 1 && LocationController.sharedController.locationManager.location != nil {
                updateremindr()
                stopActivityIndicator()
                let status = CLLocationManager.authorizationStatus()
                if status == .authorizedWhenInUse {
                    LocationController.sharedController.locationManager.requestLocation()
                }
                navigationController?.pop(animated: true)
            } else if alertSegmentedControl.selectedSegmentIndex == 0 {
                updateremindr()
                navigationController?.pop(animated: true)
            } else if alertSegmentedControl.selectedSegmentIndex == 2 {
                updateremindr()
                navigationController?.pop(animated: true)
            }
            //            overlayView.displayView(yself.view)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return true
        }
        
        func checkIfTextFieldIsEmpty() {
            if titleTextField.text?.isEmpty == true {
                saveButton.isEnabled = false
            } else if titleTextField.text?.isEmpty == false {
                saveButton.isEnabled = true
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            
            // What is this doing?
            self.titleTextField = textField
            
            
            checkIfTextFieldIsEmpty()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            checkIfTextFieldIsEmpty()
        }
        
        func startActivityIndicator() {
            if !activityIndicator.isAnimating {
                activityIndicator.startAnimating()
                saveButton.isEnabled = false
                header.backBarButtonItem?.isEnabled = false
                view.addSubview(activityIndicator)
                updatingLocationView.isHidden = false
            }
        }
        
        func stopActivityIndicator() {
            activityIndicator.stopAnimating()
            updatingLocationView.isHidden = true
        }
        
        func displayAlertForremindr(_ remindr: Remindr) {
            let alert = UIAlertController(title: remindr.title, message: remindr.notes, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "Okay", style: .default) { (alert) in
                
            }
            alert.addAction(doneAction)
            if remindr.remindrTime?.timeIntervalSince1970 > Date().timeIntervalSince1970 {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func updateremindr() {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            var latitude = LocationController.sharedController.currentLocation?.coordinate.latitude
            var longitude = LocationController.sharedController.currentLocation?.coordinate.longitude
            
            let title = titleTextField.text
            let notes = notesTextView.text
            var alertLabelText = ""
            let remindrTime = alertDatePicker.date
            
            if let remindr = self.remindr {
                remindr.title = title
                remindr.notes = notes
                if alertSegmentedControl.selectedSegmentIndex == 0 {
                    let remindrTimeString = formatter.string(from: remindrTime)
                    remindr.alertLabelText = "At \(remindrTimeString)"
                } else if alertSegmentedControl.selectedSegmentIndex == 1 {
                    remindr.alertLabelText = "Upon Moving"
                }
                remindrController.sharedController.saveToPersistentStorage()
                
            } else {
                
                // New Remindrs
                
                let location = LocationController.sharedController.locationManager.location
                latitude = location?.coordinate.latitude
                longitude = location?.coordinate.longitude
                
                switch alertSegmentedControl.selectedSegmentIndex {
                case 0:
                    if let title = titleTextField.text {
                        
                        let remindrTimeString = formatter.string(from: remindrTime)
                        alertLabelText =  "At \(remindrTimeString)"
                        let newremindr = Remindr(title: title, notes: notes!, remindrTime: remindrTime, alertLabelText: alertLabelText)
                        remindrController.sharedController.addremindr(newremindr)
                        NotificationController.sharedController.sendNotificationForRemindrWithTime(newremindr, fireDate: alertTimeDatePicker.date)
                    }
                    
                    
                case 1:
                    
                    if let title = titleTextField.text, let longitude = longitude, let latitude = latitude {
                        
                        let newremindr = Remindr(title: title, notes: notes!, alertLabelText: "Upon Moving", latitude: latitude, longitude: longitude)
                        remindrController.sharedController.addremindr(newremindr)
                        LocationController.sharedController.increaseLocationCount()
                    }
                case 2:
                    if let location = LocationController.sharedController.selectedLocation {
                        let remindr = Remindr(title: title!, notes: notes!, alertLabelText: "Upon Arriving", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        remindrController.sharedController.addremindr(remindr)
                        LocationController.sharedController.increaseLocationCount()
                    }
                default:
                    break
                }
            }
        }
        
        func updateWithremindr(_ remindr: Remindr) {
            self.remindr = remindr
            
            if remindr.alertLabelText == "Upon Moving" {
                alertSegmentedControl.selectedSegmentIndex = 1
            } else if remindr.alertLabelText == "Upon Arriving" {
                alertSegmentedControl.selectedSegmentIndex = 2
                if let name = remindr.atALocationLabelText {
                    atALocationLabel.text = "You will be reminded upon arriving at  \(name)."
                }
            } else {
                alertSegmentedControl.selectedSegmentIndex = 0
            }
            
            title = titleTextField.text
            if let title = remindr.title {
                titleTextField.text = title
            }
            if let notes = remindr.notes {
                notesTextView.text = notes
            }
            if alertSegmentedControl.selectedSegmentIndex == 0 {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                if let remindrTime = remindr.remindrTime {
                    let alertLabelText = formatter.string(from: remindrTime as Date)
                    remindr.alertLabelText = "At \(alertLabelText)"
                }
                
            } else if alertSegmentedControl.selectedSegmentIndex == 1 {
                remindr.alertLabelText = "Upon Moving"
            }
            
        }
        
        //        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //            if segue.identifier == "toMapView" {
        //            }
        //
        //        }
    }
    
    extension UIViewController: UITextFieldDelegate {
        func addToolBar(_ textField: UITextField){
            let toolBar = UIToolbar()
            toolBar.isTranslucent = true
            toolBar.barStyle = UIBarStyle.default
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.donePressed))
            doneButton.tintColor = UIColor.customCyanColor()
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            textField.delegate = self
            textField.inputAccessoryView = toolBar
        }
        func donePressed(){
            view.endEditing(true)
        }
    }
    
    extension UIViewController: UITextViewDelegate {
        func addToolBarForTextView(_ textView: UITextView){
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.donePressedForTextView))
            doneButton.tintColor = UIColor.customCyanColor()
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            textView.delegate = self
            textView.inputAccessoryView = toolBar
        }
        func donePressedForTextView(){
            view.endEditing(true)
        }
    }
    
    
    
    extension UINavigationController {
        func pop(animated: Bool) {
            _ = self.popViewController(animated: animated)
        }
        
        func popToRoot(animated: Bool) {
            _ = self.popToRootViewController(animated: animated)
        }
    }
    
    
    

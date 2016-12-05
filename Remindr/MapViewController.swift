//
//  MapViewController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 4/14/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(_ placemark: MKPlacemark)
}

class MapViewController: UIViewController, UISearchBarDelegate {
    
    var selectedPin: MKPlacemark? = nil
    
    static let sharedController = MapViewController()
    
    var selectedLocation: CLLocation?
    
    var resultSearchController: UISearchController? = nil
    
    var selectedAnnotation: MKAnnotation? = nil
    
    let currentLocation = LocationController.sharedController.locationManager.location
    let regionRadius: CLLocationDistance = 1000
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        mapView.mapType = .hybrid
        
        if let currentLocation = currentLocation {
            centerMapOnLocation(currentLocation)
        }
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for a location"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    
    func getLocation() {
        if let annotation = self.selectedAnnotation {
        let coordinate = annotation.coordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        LocationController.sharedController.selectedLocation = location
        navigationController?.pop(animated: true)
        
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(_ placemark: MKPlacemark) {
        selectedPin = placemark
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        // Change span if it's too weird looking
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            // Return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.customCyanColor()
        pinView?.canShowCallout = true
        pinView?.animatesDrop = true

        
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "Forward-50") ?? UIImage(), for: UIControlState())
        button.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        pinView?.rightCalloutAccessoryView = button
        self.selectedAnnotation = annotation
        return pinView
    }
}

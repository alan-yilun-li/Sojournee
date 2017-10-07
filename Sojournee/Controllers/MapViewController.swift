//
//  MapViewController.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-09.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addTargetButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Variables
    
    var locationManager: CLLocationManager!
    
    // MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        ViewCustomizer.setup(navigationBar: navigationController?.navigationBar)
        setup(mapView: mapView)
        
        Target.timeLabel = timeLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Misc UI Functions
    func updateDistanceLabel(forNewLocation: CLLocationCoordinate2D) {
        
    }
    
    // MARK: - IBActions 

    @IBAction func addTarget(_ sender: Any) {
        
        if mapView.annotations.count > 1 {
            
            let wipeoutAlert = UIAlertController(title: "Warning!", message: "You already have a current target. Give up and select a new one?", preferredStyle: .alert)
            
            wipeoutAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [unowned self] _ in
                self.giveNewTarget()
            }))
            wipeoutAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            present(wipeoutAlert, animated: true)
            
        } else {
        
            giveNewTarget()
        }
        
    }
    
    func giveNewTarget() {
        
        // Getting the new coordinates
        let targetCoordinate = mapView.userLocation.coordinate.randomize()
        
        // Dealing with the mapView
        mapView.removeAnnotations(mapView.annotations)
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = targetCoordinate
        mapAnnotation.title = "TARGET_PIN"
    
        mapView.addAnnotation(mapAnnotation)
        
        // Setting the target model
        Target.current = Target(pin: mapAnnotation)
        Target.current?.startTimer()
    }

}


// MARK: - MKMapViewDelegate Methods and other MapView related functions
extension MapViewController: MKMapViewDelegate {
    
    fileprivate func setup(mapView: MKMapView) {
        mapView.delegate = self
        mapView.setUserTrackingMode(.followWithHeading, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation.title != nil) && (annotation.title! == "TARGET_PIN") {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinview")
            view.animatesDrop = true
            return view
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let target = Target.current {
            let distance = target.location.distance(from: userLocation.location!)
            distanceLabel.text = "Distance: \(distance) meters"
        } else {
            distanceLabel.text = "No current target!"
        }
    }
}


























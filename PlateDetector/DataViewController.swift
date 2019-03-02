//
//  DataViewController.swift
//  PlateDetector
//
//  Created by MEDL IMAC3 on 3/2/19.
//  Copyright © 2019 Wesley Swanson. All rights reserved.
//

import UIKit
import GoogleMaps

class DataViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    let locationManager = CLLocationManager()

    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        self.startReceivingLocationChanges()
        var latitude = CLLocationDegrees(-33.86);
        var longitude = CLLocationDegrees(151.20);
        if let latitudeCoord = locationManager.location?.coordinate.latitude {
            latitude = latitudeCoord
        }
        if let longitudeCoord = locationManager.location?.coordinate.longitude {
            longitude = longitudeCoord
        }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Your Location"
//        marker.snippet = "Australia"
        marker.map = mapView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel?.text = dataObject
    }
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        
        // Do something with the location.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            return
        }
        // Notify the user of any errors.
    }

}


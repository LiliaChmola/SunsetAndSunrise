//
//  MainViewController.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/25/19.
//  Copyright © 2019 Lilia. All rights reserved.


import UIKit
import CoreLocation

class MainViewController: UIViewController {
  
    private let locationManager = CLLocationManager()
    var nameArray: [String]?
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissionStatus()
        
    }
    
    // MARK: - Actions
    @IBAction func currentLocationTapped(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        if let coordinate = locationManager.location?.coordinate {
            performSegue(withIdentifier: "detailsSeque", sender: coordinate)
        } else {
            checkPermissionStatus()
        }
    }
    
    @IBAction func tapOnMapTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "mapSeque", sender: nil)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSeque" {
            if let vc = segue.destination as? DetailsViewController,
                let coordinate = sender as? CLLocationCoordinate2D {
                vc.latitude = coordinate.latitude
                vc.longitude = coordinate.longitude
                vc.city = "Your city"
            }
        }
    }
    
    // MARK: - Private methods
    private func checkPermissionStatus() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
}




//
//  MainViewController.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/25/19.
//  Copyright © 2019 Lilia. All rights reserved.


import UIKit
import CoreLocation

class MainViewController: UIViewController {
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchCityButton: UIButton!
    @IBOutlet weak var tapOnMapButton: UIButton!
    
    private let locationManager = CLLocationManager()
    private var nameArray: [String]?
    private var isAnimationShowed = false
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissionStatus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isAnimationShowed {
            isAnimationShowed = true
            currentLocationButton.center.x  -= view.bounds.width
            searchCityButton.center.x += view.bounds.width
            tapOnMapButton.center.x -= view.bounds.width
            UIView.animate(withDuration: 0.9, delay: 0.4, options: [],
                           animations: {
                            self.currentLocationButton.center.x  += self.view.bounds.width
                            self.searchCityButton.center.x -= self.view.bounds.width
                            self.tapOnMapButton.center.x += self.view.bounds.width
            }, completion: nil)
        }
    }
    
    // MARK: - Actions
    @IBAction private func currentLocationTapped(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        if let coordinate = locationManager.location?.coordinate {
            performSegue(withIdentifier: "fromMainToDetailSegue", sender: coordinate)
        } else {
            checkPermissionStatus()
        }
    }
    
    @IBAction private func tapOnMapTapped(_ sender: UIButton) {
         performSegue(withIdentifier: "fromMainToMapSegue", sender: nil)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMainToDetailSegue" {
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




//
//  MapViewController.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/26/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var useCordinatesButton: UIButton!

    var currentAnnotation: MKPointAnnotation?

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        useCordinatesButton.layer.cornerRadius = 10.0
        useCordinatesButton.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView , toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
            useCordinatesButton.isEnabled = true
        }
    }
    
    @IBAction func useCoordinatesTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromMapToDetailSeque", sender: nil)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMapToDetailSeque" {
            if let vc = segue.destination as? DetailsViewController {
                vc.latitude = currentAnnotation?.coordinate.latitude
                vc.longitude = currentAnnotation?.coordinate.longitude
            }
        }
    }
    
    // MARK: - Private methods
    private func addAnnotation(coordinate:CLLocationCoordinate2D){
        if let unwrapedAnnotation = currentAnnotation {
            mapView.removeAnnotation(unwrapedAnnotation)
        }
        let annotation = MKPointAnnotation()
        currentAnnotation = annotation
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}


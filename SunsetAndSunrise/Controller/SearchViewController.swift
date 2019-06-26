//
//  SearchViewController.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/26/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlaces

class SearchViewController: UIViewController {
   
    @IBOutlet weak var cityNameField: UITextField!
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var city: String?
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func cityNameTapped(_ sender: UITextField) {
        cityNameField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        if cityNameField.text!.count != 0 {
            performSegue(withIdentifier: "searchDetailSeque", sender: nil)
        } else {
            let alert = UIAlertController(title: "Text field is empty", message: "Please select a city", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetailSeque" { 
            if let vc = segue.destination as? DetailsViewController {
                vc.latitude = latitude
                vc.longitude = longitude
                vc.city = city
            }
        }
    }
}

// MARK: - GMSAutocompleteViewControllerDelegate
extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        city = place.name
        cityNameField.text = city
        latitude = place.coordinate.latitude
        longitude = place.coordinate.longitude
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}



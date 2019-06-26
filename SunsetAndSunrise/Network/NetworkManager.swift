//
//  NetworkManager.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/25/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {    
    func getDetailsFor(latitude: Double, longitude: Double, date: String, completion: @escaping (Details) -> Void) {
        
        Alamofire.request("https://api.sunrise-sunset.org/json?lat=\(latitude))&lng=\(longitude)&date=\(date)&formatted=1").responseJSON{ response in
            
            if let jsonDict = response.result.value as? [String: Any],
                let resultsDict = jsonDict["results"] as? [String: Any] {
                
                if let details = Details.init(with: resultsDict) {
                    completion(details)
                }
            }
        }
    }
}

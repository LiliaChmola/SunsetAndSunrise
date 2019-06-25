//
//  File.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/25/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import Foundation

struct Details {

let sunrise: String
let sunset: String
let solarNoon: String
let dayLength: String
let civilTwilightBegin: String
let civilTwilightEnd: String
let nauticalTwilightBegin: String
let nauticalTwilightEnd: String
let astronomicalTwilightBegin: String
let astronomicalTwilightEnd: String
    
    init?(with dict: [String: Any]) {
        guard let sunrise = dict["sunrise"] as? String,
            let sunset = dict["sunset"] as? String,
            let solarNoon = dict["solar_noon"] as? String,
            let dayLength = dict["day_length"] as? String,
            let civilTwilightBegin = dict["civil_twilight_begin"] as? String,
            let civilTwilightEnd = dict["civil_twilight_end"] as? String,
            let nauticalTwilightBegin = dict["nautical_twilight_begin"] as? String,
            let nauticalTwilightEnd = dict["nautical_twilight_end"] as? String,
            let astronomicalTwilightBegin = dict["astronomical_twilight_begin"] as? String,
            let astronomicalTwilightEnd = dict["astronomical_twilight_end"] as? String else {return nil}
        
        self.sunrise = sunrise
        self.sunset = sunset
        self.solarNoon = solarNoon
        self.dayLength = dayLength
        self.civilTwilightBegin = civilTwilightBegin
        self.civilTwilightEnd = civilTwilightEnd
        self.nauticalTwilightBegin = nauticalTwilightBegin
        self.nauticalTwilightEnd = nauticalTwilightEnd
        self.astronomicalTwilightBegin = astronomicalTwilightBegin
        self.astronomicalTwilightEnd = astronomicalTwilightEnd
    }
}


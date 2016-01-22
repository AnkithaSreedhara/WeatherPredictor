//
//  WeatherModel.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
class WeatherModel : NSObject{
    var date  = ""
    var percipMM = ""
    var tempMaxC = ""
    var tempMaxF = ""
    var tempMinC = ""
    var tempMinF = ""
    var weatherCode = ""
    var weatherDesc = []
    var weatherIconUrl = []
    var winddir16Point = ""
    var winddirDegree = ""
    var windspeedKmph = ""
    var windspeedMiles = ""
}
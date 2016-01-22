//
//  CurrentCondition.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
import CoreData
class CurrentCondition : NSManagedObject{
    
    @NSManaged var cloudcover: String
    @NSManaged var humidity: String
    @NSManaged var observation_time: String
    @NSManaged var precipMM: String
    @NSManaged var pressure: String
    @NSManaged var temp_C: String
    @NSManaged var temp_F: String
    @NSManaged var visibility: String
    @NSManaged var weatherCode: String
    @NSManaged var weatherDescValue: String
    @NSManaged var weatherIconUrlValue: String
    @NSManaged var winddir16Point: String
    @NSManaged var winddirDegree: String
    @NSManaged var windspeedKmph: String
    @NSManaged var windspeedMiles: String
}

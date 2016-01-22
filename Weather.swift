//
//  Weather.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
import CoreData
class Weather : NSManagedObject{
   
    @NSManaged var date: String
    @NSManaged var precipMM: String
    @NSManaged var tempMaxC: String
    @NSManaged var tempMaxF: String
    @NSManaged var tempMinC: String
    @NSManaged var tempMinF: String
    @NSManaged var weatherCode: String
    @NSManaged var weatherDescValue: String
    @NSManaged var weatherIconUrlValue: String
    @NSManaged var winddir16Point: String
    @NSManaged var winddirDegree: String
    @NSManaged var windspeedKmph: String
    @NSManaged var windspeedMiles: String
}

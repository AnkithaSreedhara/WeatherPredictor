//
//  DayUtil.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
import UIKit
class DayUtil : NSObject{
    class func getDayOfWeek(today : String) ->String{
        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        let todayDate : NSDate = formatter.dateFromString(today)!
        let myCalendar : NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(NSCalendarUnit.WeekdayOrdinal, fromDate: todayDate)
        let weekDay = myComponents.weekdayOrdinal
        var dayName = "Sunday"
        switch weekDay
        {
        case 1: dayName = "Sunday"
            break
        case 2: dayName = "Monday"
            break
        case 3: dayName = "Tuesday"
            break
        case 4: dayName = "Wednesday"
            break
        case 5: dayName = "Thursday"
            break
        case 6: dayName = "Friday"
            break
        default:dayName = "Saturday"
        }
        return dayName
    }
}

//
//  Request.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
import CoreData
class Request : NSManagedObject{
    @NSManaged var query : String?
    @NSManaged var type : String?
}
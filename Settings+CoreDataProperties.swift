//
//  Settings+CoreDataProperties.swift
//  Rmitium
//
//  Created by Aoi Mizu on 9/14/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import CoreData

extension Settings {

    @NSManaged var sound: NSNumber
    var getSound: Bool {
        get {
            return Bool(sound)
        }
        set {
            sound = NSNumber(bool: newValue)
        }
    }
    @NSManaged var rightHand: NSNumber
    var getRightHand: Bool {
        get {
            return Bool(rightHand)
        }
        set {
            rightHand = NSNumber(bool: newValue)
        }
    }
    @NSManaged var levelOne: NSNumber?
    @NSManaged var levelTwo: NSNumber?
    @NSManaged var levelThree: NSNumber?

}
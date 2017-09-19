//
//  Randomizer.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-09.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import Foundation
import GameplayKit
import CoreLocation

struct Randomizer {
    
    /// Returns an integer from 1-10
    fileprivate static func giveOneToTen() -> Int {
        
        var random = 0
        while random == 0 {
            random = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
        }
        
        return random
    }
    
    /// Returns true or false randomly
    fileprivate static func giveTrueFalse() -> Bool {
        
        if GKRandomSource.sharedRandom().nextInt(upperBound: 2) == 1 {
            return true
        } else {
            return false
        }
    }
}

extension CLLocationCoordinate2D {
    
    func randomize() -> CLLocationCoordinate2D {
        
        let latRandomAmt = Double(Randomizer.giveOneToTen()) * 0.001
        let longRandomAmt = Double(Randomizer.giveOneToTen()) * 0.001
        
        let newLat = latitude + (Randomizer.giveTrueFalse() ? -latRandomAmt : latRandomAmt)
        let newLong = longitude + (Randomizer.giveTrueFalse() ? -longRandomAmt : longRandomAmt)
        
        return CLLocationCoordinate2D(latitude: newLat, longitude: newLong)
    }
}

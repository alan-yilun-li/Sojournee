//
//  Target.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-09.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

// A structure representing a target that the user must find.
class Target {
    
    static var current: Target?
    
    static var timeLabel: UILabel!
    
    let pin: MKAnnotation
    
    let location: CLLocation
    
    var photo: UIImage! {
        didSet {
            ImageSaver.shared.saveTakenImage(image: photo)
        }
    }
    
    var stopWatch: Timer!
    
    /// Time in deciseconds
    private var time: TimeInterval = 0

    init(pin: MKAnnotation) {
        self.pin = pin
        self.location = CLLocation(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
    }
    
    deinit {
        stopWatch.invalidate()
    }
    
    func startTimer() {
        stopWatch = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] _ in
            
            self.time += 0.01
            
            if self.time >= (60 * 60 * 100) {
                Target.timeLabel.text = "Too long!"
                self.stopWatch.invalidate()
            }

            let deciseconds = Int(self.time * 100) % 100
            let seconds = Int(self.time) % 60
            let minutes = Int(self.time / 60) % 60
            
            let decisecondsString = deciseconds < 10 ? "0\(deciseconds)" : "\(deciseconds)"
            let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            
            Target.timeLabel.text = "Time: \(minutesString):\(secondsString):\(decisecondsString)"
        })
    }
    
}

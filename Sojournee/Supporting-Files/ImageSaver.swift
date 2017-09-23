//
//  ImageSaver.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-10.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ImageSaver {
    
    static let shared = ImageSaver()
    
    private init() {}
    
    private let fileDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    
    func saveImage(image:UIImage, forLocation location: CLLocation) {
        do {
            let locationString = String(location.coordinate.latitude + location.coordinate.longitude)
            
            let fileLocation = fileDirectory!.appendingPathComponent(locationString, isDirectory: false)
            try UIImagePNGRepresentation(image)!.write(to: fileLocation, options: [.atomic])
        } catch (let error) {
            print("POP")
            print("error: \(error)")
        }
    }
}

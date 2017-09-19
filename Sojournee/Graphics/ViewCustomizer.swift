//
//  ViewCustomizer.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-09.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import Foundation
import UIKit

struct ViewCustomizer {
    
    static func setup(navigationBar navBar: UINavigationBar?) {
        
        let font = UIFont(name: "Bodoni 72", size: 24)
        UIApplication.shared.statusBarStyle = .lightContent
        navBar?.barTintColor = UIColor.skyblue
        navBar?.titleTextAttributes = [NSFontAttributeName: font as Any, NSForegroundColorAttributeName: UIColor.white]

    }
}

//
//  LoadingView.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-10.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import Foundation
import UIKit

/// Class to help present a loading indicator.
struct LoadingView {
    
    /// The singleton loadingView object.
    private static var shared: UIView!
    
    /// A property to check if the loadingView is currently active or not.
    static var isLoading: Bool {
        get {
            return shared != nil
        }
    }
    
    static func showLoadingIndicator(onView containerView: UIView, message: String) {
        
        // Initializing all the views
        
        /// View that covers the screen to make it more translucent while the spinner spins.
        let coverView = UIView()
        
        /// A box to colour the immediate area where the spinner is spinning and group it with the label.
        let indicatorBoxView = UIView()
        
        /// A label to explain why the spinner is spinning.
        let explanationLabel = UILabel()
        
        /// The indicator view that actually spins to illustrate a waiting period.
        let activityIndicator = UIActivityIndicatorView()
        
        /// A stackview to hold and organize the activityIndicator and the explanationLabel.
        let contentStackView = UIStackView(arrangedSubviews: [explanationLabel, activityIndicator])
        
        // Setting up the view hierarchy
        indicatorBoxView.addSubview(contentStackView)
        coverView.addSubview(indicatorBoxView)
        containerView.addSubview(coverView)
        
        // Configuring the spinner itself
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .white
        
        // Setting up the stack view
        contentStackView.axis = UILayoutConstraintAxis.horizontal
        
        // The spacing for everything inside the indicator box. Customize here.
        contentStackView.spacing = 20
        
        // Setting to false because we are directly adding constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setting up the cover for the screen to make it more translucent.
        coverView.frame = containerView.frame
        coverView.center = containerView.center
        coverView.backgroundColor = UIColor(white: 0.55, alpha: 0.4)
        
        // Making a label explaining why the spinner has appeared
        explanationLabel.text = message
        explanationLabel.textAlignment = .left
        explanationLabel.font = UIFont(name: "Bodoni 72", size: 17)
        explanationLabel.textColor = UIColor.white
        
        // Setting up the indicator box
        // Width is set here but there is also a constraint added to dictate it
        /// Width of the box based on the size of the explanation label and the spacing.
        let width = message.size(attributes: [NSFontAttributeName: explanationLabel.font]).width + activityIndicator.frame.width + (3 * contentStackView.spacing)
        
        indicatorBoxView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        indicatorBoxView.center = containerView.center
        indicatorBoxView.layer.cornerRadius = 8.0
        indicatorBoxView.backgroundColor = UIColor.skyblue
        indicatorBoxView.layer.opacity = 0.95
        
        // Adding constraints between the stackView and the indicatorBox (the visible view)
        
        // Adding constraint on width of indicator box (though it was set before) using our previous calculation on the message text.
        indicatorBoxView.addConstraint(NSLayoutConstraint(item: indicatorBoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width))
        
        // Adding constraints on the leading and trailing edges based on the spacing we selected.
        indicatorBoxView.addConstraint(NSLayoutConstraint(item: contentStackView, attribute: .leading, relatedBy: .equal, toItem: indicatorBoxView, attribute: .leading, multiplier: 1.0, constant: contentStackView.spacing))
        indicatorBoxView.addConstraint(NSLayoutConstraint(item: indicatorBoxView, attribute: .trailing, relatedBy: .equal, toItem: contentStackView, attribute: .trailing, multiplier: 1.0, constant: contentStackView.spacing))
        
        // Adding constraint to the bottom of the stack view.
        indicatorBoxView.addConstraint(NSLayoutConstraint(item: indicatorBoxView, attribute: .top, relatedBy: .equal, toItem: contentStackView, attribute: .top, multiplier: 1.0, constant: 0))
        indicatorBoxView.addConstraint(NSLayoutConstraint(item: indicatorBoxView, attribute: .bottom, relatedBy: .equal, toItem: contentStackView, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        // Starting the spinner
        activityIndicator.startAnimating()
        
        // Saving the loadingView singleton into the class
        LoadingView.shared = coverView // Since the coverView is the superview of our other views making up the loading spinner
        /*
        // Adding an emergency expiry timer
        Timer.scheduledTimer(withTimeInterval: emergencyShutoffTime, repeats: false, block: {
            (_ : Timer) -> Void in
            
            // Posting a notification to the view controller that location finding is complete.
            NotificationCenter.default.post(name: Constants.loadingTimeOutKey, object: nil)
        })*/
    }
    
    /// Removes the singleton loading indicator from the screen and deallocates it if it exists.
    static func removingLoadingIndicator() {
        if isLoading {
            LoadingView.shared.removeFromSuperview()
            LoadingView.shared = nil
        }
    }
    
}

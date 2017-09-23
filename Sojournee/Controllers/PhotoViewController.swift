//
//  PhotoViewController.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-09.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var webView: UIWebView!
    
    private var incrementer = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Target.current != nil {
            
            DispatchQueue.main.async {
                
                LoadingView.showLoadingIndicator(onView: self.view, message: "Loading...")
                self.view.bringSubview(toFront: self.webView)
            }
            
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] () -> Void in
                
                let severity: Double = 100000
                let latitude = round(Target.current!.location.coordinate.latitude * severity) / severity
                let longitude = round(Target.current!.location.coordinate.longitude * severity) / severity
                
                let locationString = "\(latitude),\(longitude)"
                print(locationString)
                
                let size = Int(self.webView.frame.width)
                let sizeString = "\(size)x\(size)"
                
                let postString = "location=\(locationString)&" + "size=\(sizeString)&" + "key=\(APIKeys.GOOGLE_API_KEY)"
                print(postString)
                var request = URLRequest(url: URL(string: "https://maps.googleapis.com/maps/api/streetview?" + postString)!)
                request.httpMethod = "POST"
                
                self.webView.delegate = self
                self.webView.loadRequest(request)
                
            }
            
        } else {
            view.bringSubview(toFront: photoImageView)
            photoImageView.image = #imageLiteral(resourceName: "No Image")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewCustomizer.setup(navigationBar: navigationController?.navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension PhotoViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        LoadingView.removingLoadingIndicator()
        if let target = Target.current {
            UIGraphicsBeginImageContext(webView.frame.size)
            
            let context = UIGraphicsGetCurrentContext()
            webView.layer.render(in: context!)
            
            target.photo = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
}















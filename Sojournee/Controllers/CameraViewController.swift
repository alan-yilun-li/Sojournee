//
//  CameraViewController.swift
//  pennapps-xvi
//
//  Created by Alan Li on 2017-09-10.
//  Copyright © 2017 Alan Li. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewCustomizer.setup(navigationBar: navigationController?.navigationBar)
        cameraPicture.layer.opacity = 0.4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func showCameraTapped(_ sender: Any) {
    
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) else {
            let noCameraAlert = UIAlertController(title: "Uh-oh!", message: "It looks like your camera is unavailable. Please review your settings at Settings > Privacy.", preferredStyle: .alert)
            noCameraAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(noCameraAlert, animated: true)
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: false)
    }
}

extension CameraViewController: UINavigationControllerDelegate {}


extension CameraViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the picture here
    }
    
    
    
}

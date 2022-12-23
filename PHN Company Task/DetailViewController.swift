//
//  DetailViewController.swift
//  PHN Company Task
//
//  Created by Rachana Pandit on 23/12/22.
//

import UIKit

class DetailViewController: UIViewController {
@IBOutlet weak var textViewDescription:UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewDescription.text = "Simple, yet very functional, Camera Strap V2.0 is designed to provide alternative carrying options for photographers. Durable metal rings on the Camera Strap link up with the Camera Support Straps V2.0 (sold separately)then connect to any Think Tank backpack or harness system.The CameraStrap V2.0 features silicone non-slip patterns on both sides of the strap."
      
    }
    

}

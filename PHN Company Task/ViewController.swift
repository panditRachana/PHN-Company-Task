//
//  ViewController.swift
//  PHN Company Task
//
//  Created by Rachana Pandit on 22/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.layer.cornerRadius = 15
    }

    override func viewWillAppear(_ animated: Bool)
    {
        txtUserName.text = ""
        txtPassword.text = ""
    }
    
//MARK: Button Action
    
    @IBAction func btnSubmitClick(_ sender: Any)
    {
        if(txtUserName.text!.isEmpty || txtPassword.text!.isEmpty)
        {
            let alert = UIAlertController(title: "Message", message: "Enter all values ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }
        else
        {
            let homeController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeController.userNameToFetch = txtUserName.text!
            navigationController?.pushViewController(homeController, animated: true)
        
        }
        
    }
    
}


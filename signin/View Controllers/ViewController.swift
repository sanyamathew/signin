//
//  ViewController.swift
//  signin
//
//  Created by Bellevue on 10/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
        
        func setUpElements(){
            //Utilities.styleFilledButton(signUpButton)
            //Utilities.styleHollowButton(loginButton)
        }
    }


}


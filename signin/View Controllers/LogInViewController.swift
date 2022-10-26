//
//  LogInViewController.swift
//  signin
//
//  Created by Bellevue on 10/19/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
        func setUpElements() {
            
            errorLabel.alpha = 0
            //Utilities.styleTextField(firstNameTextField)
            //Utilities.styleTextField(lastNameTextField)
            //Utilities.styleFilledButton(loginButton)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
        // VALIDATE TEXT FIELDS
        
        //CLEAN TEXT FIELDS
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        
        // SIGN IN USER
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            // CHECK FOR ERRORS
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            
            else {
                
                // GO TO HOME
                self.transitionToHome()
            }
                
        }

        
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}

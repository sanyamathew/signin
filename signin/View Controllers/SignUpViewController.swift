//
//  SignUpViewController.swift
//  signin
//
//  Created by Bellevue on 10/19/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpElements()
    {
        errorLabel.alpha = 0
        //Utilities.styleTextField(firstNameTextField)
        //Utilities.styleTextField(lastNameTextField)
        //Utilities.styleTextField(emailTextField)
        //Utilities.styleTextField(passwordTextField)
        
        //Utilities.styleFilledButton(signUpButton)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func validateFields() -> String?{
        
        //check all fields are filled in
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all fields"
        }
        //is password valid
        
        
            
        
        return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        errorLabel.alpha = 1
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        
        else {
            // CLEAN DATA
            
            let first = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //CREATE USER
            
            Auth.auth().createUser(withEmail: email, password: password) { [self](result, error) in
                
                if error != nil {
                    self.showError("Error creating user")
                }
                
                else {
                    // STORE FIRST & LAST NAME
                    let db = Firestore.firestore()          // returns firestore object
                    
                    db.collection("users").addDocument(data: [
                        "first": first,
                        "last": last,
                        "uid": result!.user.uid
                    ]) { (error) in
                        
                        if error != nil{
                            self.showError("There was an error saving data")
                        }
                    }
                }
              }
            
            // go to home screen
            self.transitionToHome()
            
        }
        
    }
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}

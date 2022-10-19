//
//  SignUpViewController.swift
//  FitnessApp
//
//  Created by Trek on 10/18/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        
        user.username = emailLabel.text
        user.password = passwordLabel.text
        user["firstname"] = firstNameLabel.text
        user["lastname"] = lastNameLabel.text
        
        user.signUpInBackground {(success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: self)
            } else {
                print("Error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LoginViewController.swift
//  FitnessApp
//
//  Created by Trek on 10/18/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        invalidLabel.isHidden = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = emailLabel.text!
        let password = passwordLabel.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {(user,error) in
            if user != nil {
                self.invalidLabel.isHidden = true
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.invalidLabel.isHidden = false
                print("error")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
//            self.performSegue(withIdentifier: "loginSegue", sender: nil)
//        }
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

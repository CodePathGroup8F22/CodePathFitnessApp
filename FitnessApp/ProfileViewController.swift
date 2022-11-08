//
//  ProfileViewController.swift
//  FitnessApp
//
//  Created by Maya Chidambaram on 11/7/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
    }
    
    @objc func getData() {
                
        let user = PFUser.current()
        firstNameLabel.text = user!["firstname"] as! String
        lastNameLabel.text = user!["lastname"] as! String
        emailLabel.text = user?.username as! String
        firstNameLabel.isHidden = false
        lastNameLabel.isHidden = false
        emailLabel.isHidden = false

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

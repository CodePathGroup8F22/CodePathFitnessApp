//
//  EditProfileViewController.swift
//  FitnessApp
//
//  Created by Trek on 11/7/22.
//

import UIKit
import Parse
import AlamofireImage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = (imageView.frame.size.width) / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSave(_ sender: Any) {
        let user = PFUser.current()
        
        let username = emailLabel.text
        let weight = weightLabel.text
        let age = ageLabel.text
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        user!["profileImage"] = file
        user!["firstname"] = username
        user!["age"] = age
        user!["weight"] = weight
        
        user!.saveInBackground{ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("SUCCESS")
            } else {
                print("error")
            }
        }
    }
    @IBAction func onProfileButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
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

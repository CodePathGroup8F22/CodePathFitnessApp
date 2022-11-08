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
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var weightTextBox: UITextField!
    @IBOutlet weak var ageTextBox: UITextField!
    @IBOutlet weak var heightTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        imageView.layer.cornerRadius = (imageView.frame.size.width) / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }
    
    @objc func getData() {
                
        let user = PFUser.current()
        
        let imageFile = user!["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        imageView.af.setImage(withURL: url)
    }
    
    @IBAction func onSave(_ sender: Any) {
        let user = PFUser.current()
        
        let username = emailTextBox.text
        let weight = weightTextBox.text
        let age = ageTextBox.text
        let height = heightTextBox.text
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        
        if (username?.isEmpty == false) { user!["firstname"] = username }
        if (weight?.isEmpty == false) { user!["weight"] = weight }
        if (age?.isEmpty == false) { user!["age"] = age }
        if (height?.isEmpty == false) {user!["height"] = height}
        user!["profileImage"] = file
        
        

        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
            
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
            
        imageView.image = scaledImage
            
        dismiss(animated: true, completion: nil)
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

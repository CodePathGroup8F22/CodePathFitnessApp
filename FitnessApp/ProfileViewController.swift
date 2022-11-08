//
//  ProfileViewController.swift
//  FitnessApp
//
//  Created by Maya Chidambaram on 11/7/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
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
        firstNameLabel.text = user!["firstname"] as? String
        emailLabel.text = user?.username as? String
        
        let imageFile = user!["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        imageView.af.setImage(withURL: url)
    }
    
    @IBAction func onProfileButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        imageView.image = scaledImage
        
        let user = PFUser.current()
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        user!["profileImage"] = file
        
        user!.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved image")
            }
            else {
                print("error")
            }
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

}

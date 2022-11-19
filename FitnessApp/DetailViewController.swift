//
//  DetailViewController.swift
//  FitnessApp
//
//  Created by Trek on 11/2/22.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    var imageStock = [UIImage(named: "stock"), UIImage(named: "stock1")]
    var workout = PFObject(className: "workout")
    @IBOutlet weak var fire1: UIImageView!
    @IBOutlet weak var fire2: UIImageView!
    @IBOutlet weak var fire3: UIImageView!
    @IBOutlet weak var fire4: UIImageView!
    @IBOutlet weak var fire5: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = workout["name"] as! String
        descriptionLabel.text = workout["description"] as! String
        imagePoster.image = imageStock[Int.random(in: 0..<2)]
        let count = workout["difficulty"] as! Int
        if count >= 1 {
            fire1.isHidden = false }
        if count >= 2 {
            fire2.isHidden = false }
        if count >= 3 {
            fire3.isHidden = false }
        if count >= 4 {
            fire4.isHidden = false }
        if count >= 5 {
            fire5.isHidden = false }
        
        if let link = workout["link"]{
            if link != nil {
                let attributedString = NSMutableAttributedString(string: "Click here to see video.")
                let url = URL(string: "\(link)")
                let boldFont = UIFont(name: "Helvetica", size: 20.0) as Any

                // Set the 'click here' substring to be the link
                attributedString.setAttributes([.link: url], range: NSMakeRange(0, attributedString.length))
                
                attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSMakeRange(0, attributedString.length))
                
                self.textView.attributedText = attributedString
                self.textView.isUserInteractionEnabled = true
                self.textView.isEditable = false
                // Set how links should appear: blue and underlined
                self.textView.linkTextAttributes = [
                    .foregroundColor: UIColor.lightGray,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
            }
            
        } else {
            textView.isHidden = true
        }
        
//        textView.isEditable = false
//        textView.text = workout["link"] as! String
//        textView.dataDetectorTypes = .link
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

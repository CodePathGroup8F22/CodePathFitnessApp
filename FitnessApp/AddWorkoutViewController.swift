//
//  AddWorkoutViewController.swift
//  FitnessApp
//
//  Created by Brandon Ng on 11/3/22.
//

import UIKit
import Parse

class AddWorkoutViewController: UIViewController {

    @IBOutlet weak var workoutField: UITextField!
    @IBOutlet weak var repField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addExerciseButton(_ sender: Any) {
        let workoutPost = PFObject(className: "workoutPost")
        
        workoutPost["workout"] = workoutField.text!
        workoutPost["reps"] = repField.text!
        workoutPost["weight"] = weightField.text!
        
        workoutPost.saveInBackground {(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
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

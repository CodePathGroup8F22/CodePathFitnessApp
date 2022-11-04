//
//  AddWorkoutViewController.swift
//  FitnessApp
//
//  Created by Brandon Ng on 11/3/22.
//

import UIKit
import Parse
import FSCalendar

class AddWorkoutViewController: UIViewController {

    @IBOutlet weak var workoutField: UITextField!
    @IBOutlet weak var repField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var setField: UITextField!
    
    var user = PFUser()
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.objectId!)
        print(date)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addExerciseButton(_ sender: Any) {
        let workoutPost = PFObject(className: "workoutPost")
        
        
        workoutPost["user"] = user.objectId!
        workoutPost["date"] = date
        workoutPost["workout"] = workoutField.text!
        workoutPost["set"] = setField.text!
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

//
//  WorkoutLogViewController.swift
//  FitnessApp
//
//  Created by Brandon Ng on 11/2/22.
//

import UIKit

class WorkoutLogViewController: UIViewController {

    @IBOutlet weak var tableViewWorkoutLog: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    var date : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = date

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Workout Log: ", date)
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

//
//  WorkoutLogViewController.swift
//  FitnessApp
//
//  Created by Brandon Ng on 11/2/22.
//

import UIKit
import Parse

class WorkoutLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewWorkoutLog: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var workoutPosts = [PFObject]()
    
    var date : String = ""
    var user = PFUser.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = date
        tableViewWorkoutLog.delegate = self
        tableViewWorkoutLog.dataSource = self
        tableViewWorkoutLog.rowHeight = 150
        getData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Workout Log: ", date)
        
    }
    
    @objc func getData() {
        let query = PFQuery(className: "workoutPost")
        query.includeKeys(["user","date"])
        query.whereKey("user", equalTo: user!.objectId!)
        query.whereKey("date", equalTo: date)
        query.limit = 20
        
        query.findObjectsInBackground{ (workout, error) in
            if workout != nil {
                var workoutPost = workout!
                self.workoutPosts = workoutPost
                self.tableViewWorkoutLog.reloadData()
            } else {
                print("Error\(String(describing: error))")
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let toViewController = segue.destination as? AddWorkoutViewController
        toViewController!.user = user!
        toViewController!.date = date
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutLogCell") as! WorkoutLogCell
        
        let workoutPost = workoutPosts[indexPath.row]
        
        cell.exerciseLabel.text = workoutPost["workout"] as? String
        
        cell.setLabel.text!.append( (workoutPost["set"] as! String) )
        cell.repLabel.text!.append( (workoutPost["reps"] as! String))
        cell.weightLabel.text!.append( (workoutPost["weight"] as! String))
        print("SUCCESS")
        return cell
        
    }
}

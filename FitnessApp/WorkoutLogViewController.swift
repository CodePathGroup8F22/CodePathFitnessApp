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
    var weekday: String = ""
    var user = PFUser.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = weekday
        tableViewWorkoutLog.delegate = self
        tableViewWorkoutLog.dataSource = self
        tableViewWorkoutLog.rowHeight = 150
        getData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Workout Log: ", date)
        getData()
        
    }
    
    @objc func getData() {
        let query = PFQuery(className: "workoutPost")
        query.includeKeys(["user","date","objectId"])
        query.whereKey("user", equalTo: user!.objectId!)
        query.whereKey("date", equalTo: date)
        query.limit = 20
        
        query.findObjectsInBackground{ (workout, error) in
            if workout != nil {
                let workoutPost = workout!
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
        
        cell.setLabel.text = "Sets: " + (workoutPost["set"] as! String)
        cell.repLabel.text = "Reps: " + (workoutPost["reps"] as! String)
        cell.weightLabel.text = "Weight: " +  (workoutPost["weight"] as! String)
//        print("SUCCESS")
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let workoutPost = workoutPosts[indexPath.row]
            print(workoutPost)
            let objectId = workoutPost.objectId as! String
            let query = PFQuery(className: "workoutPost")
            query.includeKey("objectId")
            query.whereKey("objectId", equalTo: objectId)
            query.limit = 1
            query.getObjectInBackground(withId: objectId){ (workout,error) in
                if workout != nil {
                    workout!.deleteInBackground()
                }
            }
            workoutPosts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

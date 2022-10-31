//
//  WorkoutListViewController.swift
//  FitnessApp
//
//  Created by Trek on 10/27/22.
//

import UIKit
import Parse
import AlamofireImage

class WorkoutListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var workouts = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "workout")
        query.includeKey("muscleGroup")
        query.whereKey("muscleGroup", equalTo: "Quads")
        query.limit = 20
        
        query.findObjectsInBackground{ (workout, error) in
            if workout != nil {
                self.workouts = workout!
                self.tableView.reloadData()
            } else {
                print("Error\(String(describing: error))")
            }
            
        }
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell") as! WorkoutCell
            let workout = workouts[indexPath.row]
            cell.name.text = workout["name"] as! String
            let temp = workout["difficulty"] as! Int
            cell.difficultyText.text = "Difficulty: "
            print(cell.arr)
            switch temp {
                case 1:
                cell.fire1.isHidden = false;
            case 2:
                cell.fire1.isHidden = false;
                cell.fire2.isHidden = false;
            case 3:
                cell.fire1.isHidden = false;
                cell.fire2.isHidden = false;
                cell.fire3.isHidden = false;
            case 4:
                cell.fire1.isHidden = false;
                cell.fire2.isHidden = false;
                cell.fire3.isHidden = false;
                cell.fire4.isHidden = false;
            case 5:
                cell.fire1.isHidden = false;
                cell.fire2.isHidden = false;
                cell.fire3.isHidden = false;
                cell.fire4.isHidden = false;
                cell.fire5.isHidden = false;
            default:
                print("Nothing")
            }
            return cell
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

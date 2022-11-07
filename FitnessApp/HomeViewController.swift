//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Trek on 10/27/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workoutGroup = [PFObject]()
    var imageList = [UIImage(named: "stock"), UIImage(named: "stock1"), UIImage(named: "stock2"), UIImage(named:"stock3")]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 180
        getData()
    }
    
    
    @objc func getData() {
        let query = PFQuery(className: "muscleGroup")
        query.includeKey("name")
        query.limit = 20
                
        query.findObjectsInBackground{ (workout, error) in
            if workout != nil {
            self.workoutGroup = workout!
                    self.tableView.reloadData()
                } else {
                    print("Error\(String(describing: error))")
                }
                
            }
                
        let user = PFUser.current()
        userLabel.text = (user!["firstname"] as! String) + "!"
        userLabel.isHidden = false
        tempLabel.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        let group = workoutGroup[indexPath.row]
        cell.imageLabel.text = group["name"] as! String
        
        let imageFile = imageList[indexPath.row % 4] as! UIImage
        cell.imagePoster.image = imageFile
        cell.imagePoster.layer.cornerRadius = 30
        
        
//        cell.imagePoster.af.setImage(withURL: url)
        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let group = self.workoutGroup[indexPath.row]
        let WorkoutListController = segue.destination as! WorkoutListViewController
        WorkoutListController.muscleGroup = group["name"] as! String
                
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

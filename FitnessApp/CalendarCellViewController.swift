//
//  CalendarCellViewController.swift
//  FitnessApp
//
//  Created by Andrew Olmos on 11/2/22.
//

import UIKit
import FSCalendar

class CalendarCellViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calDate : String = ""

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //print("Hello")
        var formatter = DateFormatter()
        formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let newDate = formatter.string(from: date)
        //print("New date: ", newDate)
        self.calDate = newDate
        //print("Calender date: ", calDate)
        
        self.performSegue(withIdentifier: "logSegue", sender: (Any).self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       let cell = sender as? Date
        let viewController = segue.destination as? WorkoutLogViewController
        viewController?.date = calDate
        
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

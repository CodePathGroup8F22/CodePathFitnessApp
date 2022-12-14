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
    var weekday : String = ""

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scrollDirection = .vertical
        calendar.pagingEnabled = false
        calendar.layer.cornerRadius = 30
        calendar.clipsToBounds = true
        calendar.appearance.headerSeparatorColor = UIColor(displayP3Red: 41, green: 56, blue: 83, alpha: 0)

        // Do any additional setup after loading the view.
    }
    
    

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //print("Hello")
        var formatter = DateFormatter()
        formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let newDate = formatter.string(from: date)
        //print("New date: ", newDate)
        self.calDate = newDate
        //print("Calender date: ", calDate)
        var weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE, dd"
        let newDay = weekdayFormatter.string(from: date)
        weekday = newDay
        self.performSegue(withIdentifier: "logSegue", sender: (Any).self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as? Date
        let viewController = segue.destination as? WorkoutLogViewController
        viewController?.date = calDate
        viewController?.weekday = weekday
        
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

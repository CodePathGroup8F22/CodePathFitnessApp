//
//  WorkoutCell.swift
//  FitnessApp
//
//  Created by Trek on 10/27/22.
//

import UIKit

class WorkoutCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var difficultyText: UILabel!
    @IBOutlet weak var fire1: UIImageView!
    @IBOutlet weak var fire2: UIImageView!
    @IBOutlet weak var fire3: UIImageView!
    @IBOutlet weak var fire4: UIImageView!
    @IBOutlet weak var fire5: UIImageView!
    
    var arr = [UIImageView]()
    override func awakeFromNib() {
        super.awakeFromNib()
        arr = [fire1,fire2,fire3,fire4,fire5]
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

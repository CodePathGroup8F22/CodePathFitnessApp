//
//  HomeCell.swift
//  FitnessApp
//
//  Created by Trek on 11/2/22.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

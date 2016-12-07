//
//  WeatherTableViewCell.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 17/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

	@IBOutlet weak var weatherPicImage: UIImageView!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var weatherDescriptionLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

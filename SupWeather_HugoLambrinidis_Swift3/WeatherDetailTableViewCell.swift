//
//  WeatherDetailTableViewCell.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 21/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

	@IBOutlet weak var windLabel: UILabel!
	@IBOutlet weak var weatherImage: UIImageView!
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var hourLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

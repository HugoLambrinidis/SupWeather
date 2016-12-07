//
//  Weather.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 15/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation
import CoreData

class Weather: NSManagedObject {
	
	@NSManaged var town: String
	@NSManaged var dateTimestamp: Array<Double>
	@NSManaged var date: Array<String>
	@NSManaged var weather: Array<String>
	@NSManaged var weatherDescription: Array<String>
	@NSManaged var temp: Array<String>
	@NSManaged var wind: Array<String>
}

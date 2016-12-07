//
//  WeatherEntity.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 16/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation

struct WeatherEntity {
	var date: DateHandler
	var weatherDescription: String = ""
	var weather: String = ""
	var temp: Int
	var wind: Int
}

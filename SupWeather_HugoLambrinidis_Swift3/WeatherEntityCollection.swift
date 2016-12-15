//
//  WeatherEntityCollection.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 19/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation

class WeatherEntityCollection {
	
	var weatherEntities: [WeatherEntity] = []
	var town: String
	
	init(weather: Any, type: type) {
		switch type {
		case .New:
			let arrayWeather = weather as! [String: Any]
			let arrayWeatherCity = arrayWeather["city"]! as! [String: Any]
			let arrayWeatherDetail = arrayWeather["list"] as! Array<Any>
			for element in arrayWeatherDetail {
				let e = element as! [String: Any]
				let f = e["weather"]! as! Array<Any>
				let g = f[0] as! [String: Any]
				let h = e["wind"]! as! [String: Any]
				let i = e["main"]! as! [String: Any]
				self.weatherEntities.append(WeatherEntity(
					date: DateHandler(date: e["dt_txt"] as! String),
					weatherDescription: g["description"] as! String,
					weather: g["main"] as! String,
					temp: (i["temp"] as! Int) - 273,
					wind: h["speed"] as! Int
					))
			}
			self.town = arrayWeatherCity["name"] as! String
			break
			
		case .Fetched:
			print(weather)
			let arrayEntity = weather as! Array<Any>
			let weatherFullInfosArray = arrayEntity[0] as! [String: Any]
			self.town = weatherFullInfosArray["town"] as! String
			let date = weatherFullInfosArray["date"] as! Array<String>
			for (key,element) in date.enumerated() {
				let e = weatherFullInfosArray["weatherDescription"] as! [String]
				let f = weatherFullInfosArray["weather"] as! [String]
				let g = weatherFullInfosArray["temp"] as! [Int]
				let h = weatherFullInfosArray["wind"] as! [Int]
				self.weatherEntities.append(WeatherEntity(
					date: DateHandler(date:element),
					weatherDescription: e[key],
					weather: f[key],
					temp: g[key],
					wind: h[key]
				))
			}
			break
		}
	}
	
	func selectFiveToDisplay() -> [WeatherEntity] {
		guard var tempDay = self.weatherEntities[0].date.date.day else {
			fatalError("can't find value : today")
		}
		guard var tempMonth = self.weatherEntities[0].date.date.month else {
			fatalError("can't find value : this month")
		}
		guard var tempYear = self.weatherEntities[0].date.date.year else {
			fatalError("can't find value : this year")
		}
		var fiveToDisplay: [WeatherEntity] = []
		for (key, element) in self.weatherEntities.enumerated() {
			if key == 0 {
				fiveToDisplay.append(element)
				continue
			}
			guard let hour = element.date.date.hour else {
				fatalError("can't unwrap wanted variable")
			}
			guard let day = element.date.date.day else {
				fatalError("can't unwrap wanted variable")
			}
			guard let month = element.date.date.month else {
				fatalError("can't unwrap wanted variable")
			}
			guard let year = element.date.date.year else {
				fatalError("can't unwrap wanted variable")
			}
			if day == tempDay + 1 && 11 < hour && hour < 15 {
				fiveToDisplay.append(element)
				tempDay = tempDay + 1
				continue
			}
			if month == tempMonth + 1 && 11 < hour && hour < 15 {
				fiveToDisplay.append(element)
				tempMonth = tempMonth + 1
				tempDay = 1
				continue
			}
			if year == tempYear + 1 && 11 < hour && hour < 15 {
				fiveToDisplay.append(element)
				tempYear = tempYear + 1
				tempMonth = 1
				tempDay = 1
				continue
			}
		}
		return fiveToDisplay
	}
	
	func getWeatherEntitiesFromDate (date: DateHandler) -> [WeatherEntity] {
		var weatherOfTheDay: [WeatherEntity] = []
		for element in self.weatherEntities {
			if element.date.date.day == date.date.day {
				weatherOfTheDay.append(element)
			}
		}
		return weatherOfTheDay
	}
 }

enum type {
	case New
	case Fetched
}



//
//  DateHandler.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 16/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation

class DateHandler {
	
	let dateFormatter: DateFormatter = DateFormatter()
	var date: DateComponents = DateComponents()
	let calendar: Calendar = Calendar(identifier: .gregorian)
	var dateString: String
	
	init(date:String = "", dateTimestamp: Double = 0) {
		self.dateString = date
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		if (date != "") {
			guard let date = self.dateFormatter.date(from: date) else {
				fatalError("can't create date")
			}
			self.date = self.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
		} else if (dateTimestamp != 0) {
			let date = Date(timeIntervalSince1970: dateTimestamp)
			self.date = self.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
		}
	}
	
}

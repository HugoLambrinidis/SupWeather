//
//  StoreManager.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 15/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StoreManager {
	
	let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
	let managedContext: NSManagedObjectContext;
	
	
	init() {
		self.managedContext = self.appDelegate.persistentContainer.viewContext
	}
	
	func deleteWeatherFromCoreDate() {
		let coord = appDelegate.persistentContainer.persistentStoreCoordinator
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		do {
			try coord.execute(deleteRequest, with: self.managedContext)
			print("It's Deleted ! ")
		} catch let error as NSError {
			debugPrint(error)
		}
	}
	
	func storeWeather(weatherCollection: WeatherEntityCollection, viewController: UIViewController) {
		let entity = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: managedContext)
		
		
		var date: [String] = []
		var weather: [String] = []
		var weatherDescription: [String] = []
		var wind: [Int] = []
		var temp: [Int] = []
		
		print(weatherCollection.weatherEntities)
		
		for element in weatherCollection.weatherEntities {
			date.append(element.date.dateString)
			weather.append(element.weather)
			weatherDescription.append(element.weatherDescription)
			wind.append(element.wind)
			temp.append(element.temp)
		}
		//managedContext.delete(entity)
		entity.setValue(date, forKey: "date")
		entity.setValue(weather, forKey: "weather")
		entity.setValue(weatherDescription, forKey: "weatherDescription")
		entity.setValue(weatherCollection.town, forKey: "town")
		entity.setValue(temp, forKey: "temp")
		entity.setValue(wind, forKey: "wind")
		do {
			try managedContext.save()
			print("It's saved ! ")
			self.triggerSegueToWeatherTableView(viewController: viewController)
		} catch {
			fatalError("Failure to save context: \(error)")
		}
	}
	
	func triggerSegueToWeatherTableView(viewController: UIViewController) {
		viewController.performSegue(withIdentifier: "sendDataToTableView", sender: nil)
	}
	
	func fetchStoredWeather() -> [Any]{
		let weatherContent = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
		do {
			weatherContent.resultType = .dictionaryResultType
			let fetchedWeather = try self.managedContext.fetch(weatherContent)
			return fetchedWeather
		} catch {
			fatalError("Failed to fetch Weather: \(error)")
		}
	}
	
	
	
	
}

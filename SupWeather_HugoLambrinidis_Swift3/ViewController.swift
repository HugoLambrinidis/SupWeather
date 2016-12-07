//
//  ViewController.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 15/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

	@IBOutlet weak var appTitle: UILabel!
	
	let locationManager = CLLocationManager()
	let storeManager: StoreManager = StoreManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.storeManager.deleteWeatherFromCoreDate()
		appTitle.text = Configuration.appTitle
		// get User Location
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startMonitoringSignificantLocationChanges()
		CLLocationManager.authorizationStatus()
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0]
		Configuration.Long = Double(userLocation.coordinate.longitude)
		Configuration.Lat = Double(userLocation.coordinate.latitude)
		
		// Fetch Data from Url
		WeatherDataManager(url: Configuration.urlToFetchForWeatherDataString).fetchWeatherForLocation(latitude: Configuration.Lat, longitude: Configuration.Long, apiKey: Configuration.apiKey) {
			(response, error) in
			guard let res = response else {
				print(error!)
				return
			}
			// Creating data Entity
			let entity = WeatherEntityCollection(weather: res, type: .New)
			// Saving data
			self.storeManager.storeWeather(weatherCollection: entity, viewController: self)
		}
	}


}


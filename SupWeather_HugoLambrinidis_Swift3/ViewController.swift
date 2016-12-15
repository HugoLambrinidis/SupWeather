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

	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var appTitle: UILabel!
	
	let lM = CLLocationManager()
	let storeManager: StoreManager = StoreManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		appTitle.text = Configuration.appTitle
		// get User Location
		self.lM.delegate = self;
		self.lM.desiredAccuracy = kCLLocationAccuracyBest
		self.lM.requestAlwaysAuthorization()
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func locationManager(_: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) {
		if CLLocationManager.locationServicesEnabled() {
			switch(CLLocationManager.authorizationStatus()) {
			case .notDetermined, .restricted, .denied:
				self.errorLabel.text = "plz enable localisation"
			case .authorizedAlways, .authorizedWhenInUse:
				self.errorLabel.text = ""
				lM.startMonitoringSignificantLocationChanges()
				CLLocationManager.authorizationStatus()
			}
		} else {
			self.errorLabel.text = "localisation disabled"
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0]
		Configuration.Long = Double(userLocation.coordinate.longitude)
		Configuration.Lat = Double(userLocation.coordinate.latitude)
		print("\(String(Configuration.Long)) - \(String(Configuration.Lat))")
		// Fetch Data from Url
		WeatherDataManager(url: Configuration.urlToFetchForWeatherDataString).fetchWeatherForLocation(latitude: Configuration.Lat, longitude: Configuration.Long, apiKey: Configuration.apiKey) {
			(response, error) in
			let res = response
			if res != nil {
				self.storeManager.deleteWeatherFromCoreDate()
				// Creating data Entity
				let entity = WeatherEntityCollection(weather: res!, type: .New)
				// Saving data
				if self.storeManager.storeWeather(weatherCollection: entity, viewController: self) == true {
					self.performSegue(withIdentifier: "sendDataToTableView", sender: nil)
				}
			} else {
				print(error!)
				let entity = self.storeManager.fetchStoredWeather()
				if entity[0] as! String == "error" {
					self.errorLabel.text = "can't fetch data"
				} else {
					self.performSegue(withIdentifier: "sendDataToTableView", sender: nil)
				}
				return
			}
		}
	}


}


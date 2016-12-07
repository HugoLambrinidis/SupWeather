//
//  WeatherDataManager.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 15/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation

class WeatherDataManager {
	
	let url: String
	typealias WeatherDataCompletion = (Any?, ErrorType?) -> ()
	
	
	init(url: String) {
		self.url = url
	}
	
	
	func fetchWeatherForLocation(latitude: Double, longitude: Double, apiKey: String, completion: @escaping WeatherDataCompletion) {
		// Create URL
		let urlToFetch = URL(string:"\(self.url)?APIKEY=\(apiKey)&lat=\(String(latitude))&lon=\(String(longitude))")
		
		// Create Data Task
		URLSession.shared.dataTask(with: urlToFetch!) { (data, response, error) in
			self.didFectchWeatherData(data: data, response: response, error: error, completion: completion)
			}.resume()
	}
	
	private func serializeWeatherData(data: Data, completion: WeatherDataCompletion) {
		if let JSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) {
			completion(JSON, nil)
		} else {
			completion(nil, .InvalidResponse)
		}
	}
	
	private func didFectchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
		if let _ = error {
			completion(nil, .FailedRequest)
		} else if let data = data, let response = response as? HTTPURLResponse {
			if response.statusCode == 200 {
				serializeWeatherData(data: data, completion: completion)
			} else {
				completion(nil, .FailedRequest)
			}
		} else {
			completion(nil, .Unknown)
		}
	}
	
	
}


enum ErrorType: Error {
	case Unknown
	case FailedRequest
	case InvalidResponse
}

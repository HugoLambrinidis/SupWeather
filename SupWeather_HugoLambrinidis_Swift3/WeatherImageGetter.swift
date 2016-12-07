//
//  WeatherImageGetter.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 21/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation
import UIKit

class WeatherImageGetter {
	
	var conf: Configuration = Configuration()
	
	lazy var sunImage : UIImage = {
		let sunData : Data
		do {
			sunData = try Data(contentsOf: self.conf.SunUrl)
			return UIImage(data:sunData)!
		} catch {
			fatalError("Failure to loat url: \(error)")
		}
	}()
	
	lazy var snowImage : UIImage = {
		let snowData : Data
		do {
			snowData = try Data(contentsOf: self.conf.SnowUrl)
			return UIImage(data: snowData)!
		} catch {
			fatalError("Failure to load url: \(error)")
		}
	}()
	
	lazy var rainImage: UIImage = {
		let rainData : Data
		do {
			rainData = try Data(contentsOf: self.conf.RainUrl)
			return UIImage(data: rainData)!
		} catch {
			fatalError("Failure to load url: \(error)")
		}
	}()
	
	lazy var cloudImage : UIImage = {
		let cloudData : Data
		do {
			cloudData = try Data(contentsOf: self.conf.CloudUrl)
			return UIImage(data: cloudData)!
		} catch {
			fatalError("Failure to load url: \(error)")
        }
	}()
	
	func getImageForWeather(weather: String) -> UIImage {
		switch weather {
		case "Clear":
			return self.sunImage
		case "Clouds":
			return self.cloudImage
		case "Rain":
			return self.rainImage
		case "Snow":
			return self.snowImage
		default:
			return UIImage()
		}
	}
	
}

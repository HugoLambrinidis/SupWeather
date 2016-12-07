//
//  Configuration.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 15/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import Foundation

struct Configuration {
	
	static let urlToFetchForWeatherDataString = "http://api.openweathermap.org/data/2.5/forecast"
	static let apiKey = "c6c4aa73d74cbabb16c8a3a4af74e19e"
	static var Long: Double = 0
	static var Lat: Double = 0
	static let appTitle: String = "Sup'Weather"

	lazy var SunUrl : URL = {
		return URL(string: "https://openclipart.org/image/90px/svg_to_png/220482/1433924438.png")!
	}()
	
	lazy var CloudUrl : URL = {
		return URL(string: "http://images.gofreedownload.net/nuage-cloud-5140.jpg")!
	}()
	
	lazy var RainUrl : URL = {
		return URL(string: "https://www.francestickers.com/4267-thickbox/stickers-nuage-et-pluie.jpg")!
	}()
	
	lazy var SnowUrl : URL = {
		return URL(string: "https://malignee.transilien.com/wp-content/uploads/2013/03/Neige.png")!
	}()
}

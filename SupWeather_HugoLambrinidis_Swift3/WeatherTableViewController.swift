//
//  WeatherTableViewController.swift
//  SupWeather_HugoLambrinidis_Swift3
//
//  Created by Hugo Lambrinidis on 17/11/16.
//  Copyright © 2016 Hugo Lambrinidis. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
	
	@IBOutlet weak var titleLable: UILabel!
	
	@IBOutlet weak var refreshTable: UIRefreshControl!
	
	var display: [WeatherEntity] = []
	var imageUrl : UIImage = UIImage()
	var weatherImageGetter: WeatherImageGetter = WeatherImageGetter()
	var selectedRowDate : DateHandler = DateHandler()
	let storeManager : StoreManager = StoreManager()

    override func viewDidLoad() {
        super.viewDidLoad()

		let entity = WeatherEntityCollection(weather: self.storeManager.fetchStoredWeather(), type: .Fetched)
		self.titleLable.text = entity.town
		self.display = entity.selectFiveToDisplay()
		self.refreshTable?.addTarget(self, action: #selector(WeatherTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
	}
	
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		/*WeatherDataManager(url: Configuration.urlToFetchForWeatherDataString).fetchWeatherForLocation(latitude: Configuration.Lat, longitude: Configuration.Long, apiKey: Configuration.apiKey) {
			(response, error) in
			let res = response
			if res != nil {
				self.storeManager.deleteWeatherFromCoreDate()
				// Creating data Entity
				let entity = WeatherEntityCollection(weather: res!, type: .New)
				// Saving data
				if self.storeManager.storeWeather(weatherCollection: entity, viewController: self) == true {
					let weatherEntity = WeatherEntityCollection(weather: entity, type: .Fetched)
					self.titleLable.text = weatherEntity.town
					self.display = weatherEntity.selectFiveToDisplay()
					self.tableView.reloadData()
					refreshControl.endRefreshing()
				}
			} else {
				print(error!)
				let entity = self.storeManager.fetchStoredWeather()
				if entity[0] as! String == "error" {
					print("can't fetch new data")
				} else {
					let weatherEntity = WeatherEntityCollection(weather: entity, type: .Fetched)
					self.titleLable.text = weatherEntity.town
					self.display = weatherEntity.selectFiveToDisplay()
					self.tableView.reloadData()
					refreshControl.endRefreshing()
				}
				return
			}
		}*/
		self.performSegue(withIdentifier: "refreshSegue", sender: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.display.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
		
		
		cell.weatherDescriptionLabel.text = self.display[indexPath[1]].weatherDescription
		let date = self.display[indexPath[1]].date
		let dateString = "\(String(describing: date.date.day!)) / \(String(describing: date.date.month!))"
		cell.dateLabel.text = dateString
		cell.weatherPicImage.image = self.weatherImageGetter.getImageForWeather(weather: self.display[indexPath[1]].weather)
		
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.selectedRowDate = self.display[indexPath[1]].date
	}
	
	/*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> UITableViewCell {
		
	
		
	
        // Return false if you do not want the specified item to be editable.
        return cell
    }
*/
	

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if segue.identifier == "toDetailView" {
			let destination = segue.destination as! WeatherDetailTableViewController
			let entity = WeatherEntityCollection(weather: self.storeManager.fetchStoredWeather(), type: .Fetched)
			destination.weather = entity.getWeatherEntitiesFromDate(date: self.display[(tableView.indexPathForSelectedRow?.row)!].date)
		}
    }


}

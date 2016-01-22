//
//  ViewController.swift
//  Weather Predictor
//
//  Created by Anki on 13/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    //Outlets
    @IBOutlet weak var collectionViewDailyUpdate: UICollectionView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgForeCast: UIImageView!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var imgViewAirElement: UIImageView!
    @IBOutlet weak var lblAirElement: UILabel!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var imgViewRainChance: UIImageView!
    @IBOutlet weak var lblRainChance: UILabel!
    @IBOutlet weak var imgViewHumidity: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    
    var current_Climate = [CurrentCondition]()
    var weeklyWeatherDetails = [Weather]()
    var requests = [Request]()
    var weatherImages = [UIImage]()
    
    // #pragma mark - Core Data Helper
    
    lazy var cdstore: CoreDataStore = {
        let cdstore = CoreDataStore()
        return cdstore
    }()
    
    lazy var cdh: CoreDataHelper = {
        let cdh = CoreDataHelper()
        return cdh
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewDailyUpdate.delegate = self
        self.collectionViewDailyUpdate.dataSource = self
        let url = NSURL(string: "http://api.worldweatheronline.com/free/v1/weather.ashx?q=bangalore&format=json&num_of_days=5&key=329c87ezzdxyx73v8wahx9cm")
        DataManager.loadDataFromURL(url!, completion: {(data,error) -> Void in
            print(data)
            if(data != nil){
                let json = JSON(data: data!)
                let error : NSError?
                do{
                    let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    let results = jsonDict["data"] as! NSDictionary
                    let currentCondition = results["current_condition"] as! NSArray
                    for current in currentCondition{
                        let current_condition : CurrentCondition = NSEntityDescription.insertNewObjectForEntityForName("CurrentCondition", inManagedObjectContext: self.cdh.backgroundContext!) as! CurrentCondition
                        current_condition.cloudcover = (current["cloudcover"]! as! String)
                        current_condition.humidity = (current["humidity"]! as! String)
                        current_condition.observation_time = (current["observation_time"]! as! String)
                        current_condition.precipMM = (current["precipMM"]! as! String)
                        current_condition.pressure = (current["pressure"]! as! String)
                        current_condition.temp_C = (current["temp_C"]! as! String)
                        current_condition.temp_F = (current["temp_F"]! as! String)
                        current_condition.visibility = (current["visibility"]! as! String)
                        current_condition.weatherCode = (current["weatherCode"]! as! String)
                        current_condition.weatherDescValue = ((current["weatherDesc"]! as! NSArray)[0].valueForKey("value") as? String)!
                        current_condition.weatherIconUrlValue = ((current["weatherIconUrl"]! as! NSArray)[0].valueForKey("value") as? String)!
                        current_condition.winddir16Point = (current["winddir16Point"]! as! String)
                        current_condition.winddirDegree = (current["winddirDegree"]! as! String)
                        current_condition.windspeedKmph = (current["windspeedKmph"]! as! String)
                        current_condition.windspeedMiles = (current["windspeedMiles"]! as! String)
                        
                        dispatch_async(dispatch_get_main_queue()){
                            self.lblAirElement.text = current_condition.windspeedKmph + " KMPH"
                            self.lblCurrentTemp.text = current_condition.temp_C + " °C"
                            self.lblHumidity.text = current_condition.humidity + "%"
                            self.lblDescription.text = current_condition.weatherDescValue
                            self.lblRainChance.text = current_condition.cloudcover + "%"
                            self.lblDirection.text = current_condition.winddir16Point
                            self.lblTime.text = current_condition.observation_time
                            
                            let imageUrl = current_condition.weatherIconUrlValue
                            self.imgForeCast.image = ImageUtil.getImageFromUrl(imageUrl)
                        }
                        self.cdh.saveContext(self.cdh.backgroundContext!)
                        self.current_Climate.append(current_condition)
                    }
                    let requests = results["request"] as! NSArray
                    for request in requests{
                        let requestObject = NSEntityDescription.insertNewObjectForEntityForName("Request", inManagedObjectContext: self.cdh.backgroundContext!) as! Request
                        requestObject.query = request["query"] as? String
                        requestObject.type = request["type"] as? String
                        dispatch_async(dispatch_get_main_queue()){
                            self.lblLocation.text = requestObject.query
                        }
                        self.requests.append(requestObject)
                        self.cdh.saveContext(self.cdh.backgroundContext!)
                    }
                    let restDaysWeather = results["weather"] as! NSArray
                    for dailyWeather in restDaysWeather{
                        let weather = NSEntityDescription.insertNewObjectForEntityForName("Weather", inManagedObjectContext: self.cdh.backgroundContext!) as! Weather
                        weather.date = (dailyWeather["date"]! as! String)
                        weather.tempMaxC = (dailyWeather["tempMaxC"]! as! String)
                        weather.tempMaxF = (dailyWeather["tempMaxF"]! as! String)
                        weather.tempMinC = (dailyWeather["tempMinC"]! as! String)
                        weather.tempMinF = (dailyWeather["tempMinF"]! as! String)
                        weather.precipMM = (dailyWeather["precipMM"]! as! String)
                        weather.weatherCode = (dailyWeather["weatherCode"]! as! String)
                        weather.weatherDescValue = (dailyWeather["weatherDesc"]! as! NSArray)[0].valueForKey("value") as! String
                        weather.weatherIconUrlValue = (dailyWeather["weatherIconUrl"]! as! NSArray)[0].valueForKey("value") as! String
                        let imageUrl = weather.weatherIconUrlValue
                        let image = ImageUtil.getImageFromUrl(imageUrl)
                        self.weatherImages.append(image)
                        
                        
                        weather.winddir16Point = (dailyWeather["winddir16Point"]! as! String)
                        weather.winddirDegree = (dailyWeather["winddirDegree"]! as! String)
                        weather.windspeedKmph = (dailyWeather["windspeedKmph"]! as! String)
                        weather.windspeedMiles = (dailyWeather["windspeedMiles"]! as! String)
                        self.weeklyWeatherDetails.append(weather)
                        
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.collectionViewDailyUpdate.reloadData()
                        }
                    }
                    self.cdh.saveContext(self.cdh.backgroundContext!)
                }
                catch{
                    print(error)
                }
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.weeklyWeatherDetails.count)
        return self.weeklyWeatherDetails.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DailyUpdatingViewCell
        
        cell.lblDate.text = weeklyWeatherDetails[indexPath.row].date
        print(cell.lblDate.text!)
        cell.lblDay.text = DayUtil.getDayOfWeek(cell.lblDate.text!)
        cell.lblTemp?.text = weeklyWeatherDetails[indexPath.row].tempMaxC + "°C"
        cell.imgViewForForecastType?.image = weatherImages[indexPath.row]
        //        cell.lblDirection?.text = weeklyWeatherDetails[indexPath.row].winddir16Point
        //        cell.imgViewWindSpeed?.text = weeklyWeatherDetails[indexPath.row].windspeedKmph + "KMPH"
        //        cell.lblMaxTemp?.text = weeklyWeatherDetails[indexPath.row].tempMaxC + "°C"
        //        cell.lblMinTemp?.text = weeklyWeatherDetails[indexPath.row].tempMinC + "°C"
        cell.lblDescription?.text = weeklyWeatherDetails[indexPath.row].weatherDescValue
        return cell
    }
    
}


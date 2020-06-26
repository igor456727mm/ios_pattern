//
//  MainViewController.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherMainViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var CityTitle2: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var CountryTitle: UILabel!
    @IBOutlet weak var GradusTitle: UILabel!
    @IBOutlet weak var Description: UILabel!
    
   
    
    @IBOutlet weak var WinterTitle: UILabel!
    
    @IBOutlet weak var TermTitle: UILabel!
    @IBOutlet weak var RainTitle: UILabel!
    let locManager =  CLLocationManager()
    var local: CLLocation?
    var presenter: WeatherMainViewPresenterProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self as! UICollectionViewDelegate
        CollectionView.dataSource = self as! UICollectionViewDataSource
        //CollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier:"menuCell")
        
        var nib=UINib(nibName: "CollectionViewCell", bundle:nil)
        CollectionView.register(nib, forCellWithReuseIdentifier: "menuCell")
        
        self.locManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
           
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
            
            /*switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                }*/
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
            if let location = locations.first {
               
                self.presenter.updateLocal(location: location)
                manager.stopUpdatingLocation()
                
            }
       
    }
    
    @IBAction func GoDetail(_ sender: Any) {
       
        presenter.tabOnThePost(weather: presenter.weather, city: (self.CityTitle2!.titleLabel?.text ?? ""))
    }
    
    
}

extension WeatherMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //presenter.weather?.fact
        //print((presenter.weather?.forecasts?.parts?)!)
        
        if let dayShot = presenter.weather?.forecasts?[0].hours {
            
            return dayShot.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? CollectionViewCell {
            //print(itemCell.title?.text)
            if let elemet = presenter.weather!.forecasts!.first {
                itemCell.title?.text = (elemet.hours?[indexPath.row].hour ?? "0") + ":00"
                itemCell.gradus?.text = String(elemet.hours?[indexPath.row].temp ?? 0) + "C"
                itemCell.webView?.loadHTMLString("<body style='width:100%;height:100%'> <html style='width:100%;height:100%'> <img style='width: 20%; height: 20%; object-fit:cover' src='https://yastatic.net/weather/i/icons/blueye/color/svg/\(String((elemet.hours?[indexPath.row].icon)!) ).svg'> </body> </html>", baseURL: nil)
            }
            
            return itemCell
        }
        
        return CollectionViewCell()
    }
    
    
}

extension WeatherMainViewController: WeatherMainViewProtocol {
    func country(location: CLLocation) {
        
        if location != nil {
            
             let geoCoder = CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                      guard let currentLocPlacemark = placemarks?.first else { return }
                        self.CountryTitle.text = (currentLocPlacemark.isoCountryCode ?? "No country found")
                        self.CityTitle2.setTitle(currentLocPlacemark.locality, for: .normal)
                  }
        }
    }
    
    
    func location() -> CLLocation? {
        self.locManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
           
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
            /*switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }*/
            
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
               CLLocationManager.authorizationStatus() ==  .authorizedAlways
            {
                var str = Coordinate()
                str.latitude = locManager.location?.coordinate.latitude
                str.longitude = locManager.location?.coordinate.longitude
                
                
                return locManager.location
            }
            
        }
        return locManager.location
    }
    
    func succsess() {
        let weather = presenter.weather
        //self.CityTitle2.setTitle(weather?.info?.tzinfo?.name, for: .normal)
        //self.CityTitle.text =
        self.GradusTitle.text =  weather?.fact?.temp?.description
        self.WinterTitle.text = (weather?.fact?.wind_speed!.description)! + " м/с"
        
        self.RainTitle.text = (weather?.fact?.humidity!.description)! + "%"
        self.TermTitle.text = (weather?.fact?.pressure_mm!.description)! + " р.c."
        
        self.Description.text = "Сила осадков: "
        switch weather?.fact?.prec_strength {
            case 0: self.Description.text! += " без осадков. "
            case 0.25: self.Description.text! += " слабый дождь/слабый снег. "
            case 0.5 : self.Description.text! += " дождь/снег. "
            case 0.75 : self.Description.text! += "  сильный дождь/сильный снег "
            case 1 : self.Description.text! += "  сильный ливень/очень сильный снег. "
            
        case .none:
            self.Description.text! = ""
        case .some(_):
            self.Description.text! = ""
        }
        self.Description.text! += "Облачность: "
        
        switch weather?.fact?.cloudness {
            case 0: self.Description.text! += " ясно. "
            case 0.25: self.Description.text! += " малооблачно. "
            case 0.5 : self.Description.text! += " облачно с прояснениями. "
            case 0.75 : self.Description.text! += "  облачно с прояснениями. "
            case 1 : self.Description.text! += "  пасмурно. "
            
        case .none:
            self.Description.text! = ""
        case .some(_):
            self.Description.text! = ""
        }
        
       self.CollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}


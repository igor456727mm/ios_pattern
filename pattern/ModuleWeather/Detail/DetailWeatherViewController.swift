//
//  DetailWeatherViewController.swift
//  pattern
//
//  Created by Igor Selivestrov on 24.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import  CoreData


class DetailWeatherViewController: UIViewController {
    @IBOutlet weak var city: UILabel! 
    @IBOutlet weak var CityImage: UIImageView!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var text: UILabel!
    var presenter: DetailWeatherViewPresenterProtocol!
    public static var userText:String {
           get {
                return UserDefaults.standard.object(forKey: "userText") as! String
           }
           set(newValue) {
               
               UserDefaults.standard.set(newValue, forKey: "userText")
               UserDefaults.standard.synchronize()
           }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setWeather()
        CollectionView.delegate = self as! UICollectionViewDelegate
        CollectionView.dataSource = self as! UICollectionViewDataSource
        var nib=UINib(nibName: "CollectionViewCell", bundle:nil)
        CollectionView.register(nib, forCellWithReuseIdentifier: "menuCell")
        
        if let url = presenter.cityArray?.hits {
            
            self.CityImage?.setCustomImage(url.first?.webformatURL)
            self.text?.text = (UserDefaults.standard.object(forKey: "userText") ?? "") as? String
        }
        //presenter.setWeather(weather: Weather?, city: String?)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterText(_ sender: Any) {
        let Alert = UIAlertController(title: "Оформление заказа", message: "Подтвердите учетные данные перед отправкой заказа", preferredStyle: .alert)
        Alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Пользовательский текст"
            textField.text = (UserDefaults.standard.object(forKey: "userText") ?? "") as? String
            textField.textAlignment = .left
        })
        
        
        
        let ActionBy = UIAlertAction(title: "Сохранить", style: .default) {
            (action) in
            
            let text = Alert.textFields![0]
            UserDefaults.standard.set((text.text ?? ""), forKey: "userText")
            self.text?.text = text.text
            
        }
        let ActionCencle = UIAlertAction(title: "Отменить", style: .default) {
            (action) in
           
            
        }
        
        Alert.addAction(ActionCencle)
        Alert.addAction(ActionBy)
        self.present(Alert, animated: true, completion: nil)
    }
    
}

extension DetailWeatherViewController : UICollectionViewDelegate, UICollectionViewDataSource {
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

extension DetailWeatherViewController: DetailWeatherViewProtocol {
    func succsess() {
        if let url = presenter.cityArray?.hits {
            
            self.CityImage?.setCustomImage(url.first?.webformatURL)
            self.text?.text = (UserDefaults.standard.object(forKey: "userText") ?? "") as? String
        }
       
    }
    
    func failure(error: Error) {
        
    }
    
    
    func setWeather( weather: Weather?, city: String?)  {
        if let cityLabel = self.city {
            self.city.text = city
        }
        
       
     }
    
}
extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else { return  }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "weather")
                
            }
        }
    }
}

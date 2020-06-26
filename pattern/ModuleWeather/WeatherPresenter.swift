//
//  MainPresenter.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherMainViewProtocol : class {
    func succsess()
    func failure(error: Error)
    func location() ->  CLLocation?
    func country(location: CLLocation)
    
}
protocol WeatherMainViewPresenterProtocol: class {
    init(view: WeatherMainViewProtocol, networkService: NetworkServiceProtocol, router: WeatherRouterProtocol, local: Location)
    func getWeather(local: CLLocation)
    var weather: Weather? { get set }
    func tabOnThePost(weather: Weather?, city: String?)
    var Coordinate: Coordinate? { get set }
    func updateLocal(location: CLLocation)
}

class WeatherMainPresenter: WeatherMainViewPresenterProtocol {
    
    func updateLocal(location: CLLocation) {
        self.view?.country(location: location)
        
        let location = self.view?.location()
        getWeather(local: (location as CLLocation?)!)
        //print(location)
    }
    
    var Coordinate: Coordinate?
    
    
    var weather: Weather?
    weak var view: WeatherMainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router : WeatherRouterProtocol?
    
    func getWeather(local: CLLocation) {
        networkService.getWeather(local: local) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    //case .success(let stringJson): print(stringJson)
                case .success(let weather): self.weather = weather
                    self.view?.succsess()
                case .failure( let error):
                    self.view?.failure(error: error)
                }
            }
            
        }
    }
    
    func tabOnThePost(weather: Weather?, city: String?) {
     
       router?.showDetail(weather: weather, city: city)
   }
    
    
    required init(view: WeatherMainViewProtocol, networkService: NetworkServiceProtocol, router: WeatherRouterProtocol, local: Location) {
        self.view = view
        let location = self.view?.location()
        
        self.networkService = networkService
        
        if location != nil {
            getWeather(local: location as! CLLocation)
            print(weather)
        }
        
        self.router = router
    }
    
    
    
    
}

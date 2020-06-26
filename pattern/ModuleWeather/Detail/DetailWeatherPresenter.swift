//
//  DetailPresenter.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

protocol DetailWeatherViewProtocol: class {
    func setWeather(weather: Weather?, city: String?)
    func succsess()
    func failure(error: Error)
}

protocol DetailWeatherViewPresenterProtocol: class {
    init(view: DetailWeatherViewProtocol, networkService: NetworkServiceProtocol, weather: Weather?, router: WeatherRouterProtocol, city: String? )
    func setWeather()
    func tab()
    func getCityimage()
    var cityArray: City? { get set }
    var weather: Weather? { get set }
}

class DetailWeatherPresenter: DetailWeatherViewPresenterProtocol {
    func tab() {
        router?.popToRoot()
    }
    func getCityimage() {
        networkService.getCityimage(cityName: self.city, completion: { [weak self] result in
           guard let self = self else { return }
                      DispatchQueue.main.async {
                          switch result {
                              //case .success(let stringJson): print(stringJson)
                          case .success(let city): self.cityArray = city
                              self.view?.succsess()
                          case .failure( let error):
                              self.view?.failure(error: error)
                          }
                      }
        })
    }
    var cityArray: City?
    
    var city : String?
    var weather: Weather?
    weak var view: DetailWeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: WeatherRouterProtocol?
    required init(view: DetailWeatherViewProtocol, networkService: NetworkServiceProtocol, weather: Weather?, router: WeatherRouterProtocol, city: String? ) {
        self.city = city
        self.view = view
        self.networkService = networkService
        self.weather = weather
        getCityimage()
        self.router = router
        
    }
    
    func setWeather()
    {
        self.view?.setWeather(weather: self.weather, city: self.city)
    }
    
    
}

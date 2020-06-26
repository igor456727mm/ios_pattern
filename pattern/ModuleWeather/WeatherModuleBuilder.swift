//
//  File.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherAsselderBuilderProtocol {
     func createMainModule(router: WeatherRouterProtocol) -> UIViewController
     func createDetailModule(weather: Weather?, router: WeatherRouterProtocol, city: String?) -> UIViewController
}
class WeatherAsselderModuleBuilder:WeatherAsselderBuilderProtocol {
    func createMainModule(router: WeatherRouterProtocol) -> UIViewController {
        let view = WeatherMainViewController()
        let networkService = NetworkService()
        let local = Location()
        let presenter = WeatherMainPresenter(view: view, networkService: networkService, router: router, local: local)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(weather: Weather?, router: WeatherRouterProtocol, city: String?) -> UIViewController {
        let view = DetailWeatherViewController()
        view.setWeather(weather: weather, city: city)
        let networkService = NetworkService()
        let presenter = DetailWeatherPresenter(view: view, networkService: networkService, weather: weather, router: router, city: city)
        view.presenter = presenter
        return view 
    }
    
    
    
}

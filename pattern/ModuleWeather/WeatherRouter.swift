//
//  Router.swift
//  pattern
//
//  Created by Igor Selivestrov on 24.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation


import Foundation
import UIKit

protocol WeatherRouterMain {
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: WeatherAsselderBuilderProtocol? { get set }
    
}

protocol WeatherRouterProtocol: WeatherRouterMain{
    func initialViewController()
    func showDetail(weather: Weather?, city: String?)
    func popToRoot()
    
}
class WeatherRouter: WeatherRouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: WeatherAsselderBuilderProtocol?
    init(navigationController: UINavigationController, assemblyBuilder: WeatherAsselderBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialViewController() {
        if let navigationController = navigationController {
            guard  let mainViewController = assemblyBuilder?.createMainModule( router: self) else {
                return
            }
            navigationController.viewControllers = [mainViewController]
            
        }
        
    }
    
    func showDetail(weather: Weather?, city: String?) {
        if let navigationController = navigationController {
            guard  let detailViewController = assemblyBuilder?.createDetailModule(weather: weather, router: self, city: city) else {
                return
            }
            navigationController.pushViewController(detailViewController, animated: true)
            
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            
            navigationController.popViewController(animated: true)
            
        }
    }
    
    
}

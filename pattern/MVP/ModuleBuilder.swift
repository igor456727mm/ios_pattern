//
//  File.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import UIKit
protocol AsselderBuilderProtocol {
     func createMainModule(router: RouterProtocol) -> UIViewController
     func createDetailModule(post: Post?, router: RouterProtocol) -> UIViewController
}
class AsselderModuleBuilder:AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        //let person = Person(firstName: "Igor", lastName: "Selivestrov")
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(post: Post?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, post: post, router: router)
        view.presenter = presenter
        return view
    }
    
    
    
}

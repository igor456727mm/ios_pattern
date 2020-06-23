//
//  File.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import UIKit
protocol Builder {
    static func createMainModule() -> UIViewController
    
}
class ModuleBuilder:Builder {
    static func createMainModule() -> UIViewController {
        let person = Person(firstName: "Igor", lastName: "Selivestrov")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: person)
        view.presenter = presenter
        return view
    }
}

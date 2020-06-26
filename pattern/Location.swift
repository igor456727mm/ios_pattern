//
//  Location.swift
//  pattern
//
//  Created by Igor Selivestrov on 24.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProtocol {
    func getLocation()
    var locManager: CLLocationManager { get set }
    
}
class Location: LocationProtocol {
    
    var locManager = CLLocationManager()
    
    func getLocation() {
        
    }
    
    
}

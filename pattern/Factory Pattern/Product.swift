//
//  Product.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

protocol Product {
    var Name: String { get }
    var type: String { get }
    
    func start()
    func stop()
}

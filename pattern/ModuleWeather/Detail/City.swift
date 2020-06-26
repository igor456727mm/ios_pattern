//
//  City.swift
//  pattern
//
//  Created by Igor Selivestrov on 26.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

struct City: Decodable {
    var hits: [ImageArray]?
    struct ImageArray:Decodable {
        var webformatURL: String?
    }
}

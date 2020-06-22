//
//  ParamsDefault.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

class ParamsDefault: Product {
    var Name: String = "Дефолтные значения"
    
    var type: String = "Дефолтный тип"
    
    func start() {
        print("Начало")
    }
    
    func stop() {
        print("Завершение")
    }
    
    
}

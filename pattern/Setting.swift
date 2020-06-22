//
//  Setting.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit

struct Element {
    var Name:String? = "Product"
    var Label:String? = "Продукция"
    var Title:String? = "Продукция в наличае у поставщика"
}

class Setting {
    
    static let shared = Setting()
    
    var Product: Element { 
        
        return Element()
    }
    var urlString: String? = "https://jsonplaceholder.typicode.com/posts"
    private init() {
        
    }
}

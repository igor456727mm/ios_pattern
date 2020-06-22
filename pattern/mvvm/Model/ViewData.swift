//
//  ViewData.swift
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

 enum ViewData {
    case initial
    case loading(Data)
    case succsess(Data)
    case failure(Data)
    
    struct Data {
        let icon:  String?
        let title: String?
        let description: String?
        let numberPhone: String?
    }
}

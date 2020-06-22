//
//  FactoryProduct.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

enum ProductsParams {
    case Params, DefaultParams
}

class FactoryProducts {
    static let defaultFactory = FactoryProducts()
    func createParams(name: ProductsParams) -> Product {
        switch name {
            case .DefaultParams: return ParamsDefault()
            case .Params: return Params()
        }
    }
}

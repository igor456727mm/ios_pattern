//
//  ProductController.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit

class ProductController: UIViewController {
    var ProductArray = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createProductParams(parName: .DefaultParams)
        runProduct()
    }
    
    func createProductParams(parName: ProductsParams)  {
        let newParams = FactoryProducts.defaultFactory.createParams(name: parName)
        ProductArray.append(newParams)
    }
    
    func runProduct()
    {
        for param in ProductArray {
            param.start()
            param.stop()
        }
    }
}

//
//  Closure.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import Foundation

class ClosureController: UIViewController {
    typealias Completion = () -> ()
    var jsonString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.fetch { [weak self ] (json) in
            guard let self = self else { return }
            print(Thread.current)
            DispatchQueue.main.async {
                print(Thread.current)
                self.jsonString = json 
                print(self.jsonString as Any)
            }
           
        }
    }
    
}

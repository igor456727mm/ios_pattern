//
//  NetworkService.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import Foundation

class NetworkService {
    class func fetch(completion: @escaping (String) -> ())
    {
        guard let urlString = Setting.shared.urlString as String? else { return  }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
            if error != nil {
                print("error")
            }
            guard let data = data else { return }
            guard let  jsonString = String(data: data, encoding: .utf8) else { return }
            completion(jsonString)
        }
        task.resume()
        
    }
}

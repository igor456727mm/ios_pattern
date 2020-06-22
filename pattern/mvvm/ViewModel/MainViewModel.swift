//
//  MainViewModel.swift
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
    var jsonString: ((String) -> ())? {get set }
    var updateViewData: ((ViewData ) -> ())? { get set }
    func startFetch()
    func error()
}
final class MainViewModel: MainViewModelProtocol {
    var jsonString: ((String) -> ())?
    
    var updateViewData: ((ViewData ) -> ())?
    
    init() {
        updateViewData?(.initial)
    }
    func startFetch() {
        NetworkService.fetch { [weak self ] (json) in
            guard let self = self else { return }
            print(Thread.current)
            DispatchQueue.main.async {
                print(Thread.current)
                //self.jsonString = json
                self.updateViewData?(.loading(ViewData.Data(icon: nil, title: nil, description: nil, numberPhone: nil)))
                print(json as Any)
            }
          
        }
      
    }
    func error() {
        print("error")
    }
    
    
}

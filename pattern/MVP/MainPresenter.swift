//
//  MainPresenter.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

protocol MainViewProtocol : class {
    func setGreeting(greeting: String)
}
protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, person: Person)
    func showGreeting()
}

class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let person: Person
    
    required init(view: MainViewProtocol, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = self.person.lastName + " " + self.person.firstName
        self.view.setGreeting(greeting: greeting)
    }
    
    
    
}

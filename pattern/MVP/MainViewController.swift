//
//  MainViewController.swift
//  pattern
//
//  Created by Igor Selivestrov on 23.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    var presenter: MainViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTabButtomAction(_ sender: UIButton) {
        self.presenter.showGreeting()
    }
}

extension MainViewController: MainViewProtocol {
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    
    
}

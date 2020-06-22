//
//  MvvmController.swift
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation
import UIKit
class MvvmController : UIViewController {
    private var viewModel: MainViewModelProtocol!
    private var testView: TestView!
    
    override func viewDidLoad() {
        viewModel = MainViewModel()
        super.viewDidLoad()
        
        createView()
        updateView()
    }
    private func createView() {
        testView = TestView()
        testView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        testView.center = view.center
        view.addSubview(testView)
    }
    private func updateView()
    {
        viewModel.updateViewData = { [weak self] viewData in
            self?.testView.ViewData = viewData
        }
    }
    @IBAction func startAction(_ Sender: Any) {
        viewModel.startFetch()
    }
    @IBAction func errorAction(_ Sender: Any) {
        viewModel.error()
    }
}

//
//  TestView.swift
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit

class TestView: UIView {
    var ViewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch ViewData {
        case .initial : update(viewData: nil, isHidden: true)
            case .loading(let loading) : update(viewData: loading, isHidden: false)
            case .succsess(let success) : update(viewData: success, isHidden: false)
            case .failure(let failure) : update(viewData: failure, isHidden: false)
              
        }
    }
    private func update(viewData: ViewData.Data?, isHidden: Bool) {
        //some change uielement
        //viewData?.icon viewData?.title viewData?.description viewData?.numberPhone
    }
}

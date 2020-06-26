//
//  CollectionViewCell.swift
//  pattern
//
//  Created by Igor Selivestrov on 25.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import WebKit
class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var gradus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

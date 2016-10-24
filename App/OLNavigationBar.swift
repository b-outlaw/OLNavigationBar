//
//  OLNavigationBar.swift
//  Navigation Controller
//
//  Created by Brandon Outlaw on 10/19/16.
//  Copyright © 2016 Goldstar Events, Inc. All rights reserved.
//

import UIKit
import Foundation

class OLNavigationBar: UINavigationBar {

    let buttons: [UIButton] = []
    let scrollingNavBar = OLScrollingNavBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        scrollingNavBar.barItems = ["Enamel Pin", "Quinoa", "Live-Edge", "Pork belly ", "Kombucha", "mlkshk"]
        topItem?.titleView = scrollingNavBar
    }

}

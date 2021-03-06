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

    let scrollingNavBar = OLScrollingNavBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        barStyle = .default
        barTintColor = .blue
        self.isTranslucent = false

        scrollingNavBar.barItems = ["Enamel Pin", "Quinoa", "Live-Edge", "Pork belly ", "Kombucha", "mlkshk"]
        let themeConfig = OLScrollingNavBar.Theme(withDictionary: [
            "backgroundColor" : UIColor.clear,
            "normalTextColor" : UIColor.white,
            "activeTextColor" : UIColor.yellow,
            "horizontalInsets" : NSValue(uiEdgeInsets: UIEdgeInsetsMake(0, 40, 0, 40)),
            "font" : UIFont.boldSystemFont(ofSize: 16)
        ])
        scrollingNavBar.themeConfig = themeConfig

        topItem?.titleView = scrollingNavBar
    }

}

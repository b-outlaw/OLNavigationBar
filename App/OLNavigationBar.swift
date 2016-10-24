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
    let aview = OLScrollingNavBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        var xPos: CGFloat = 0
        for index in 1...20 {
            // Initialize and configure button.
            let button = UIButton(type: .custom)
            let color: CGFloat = (CGFloat(index) * CGFloat(20)) / 255.0
            button.setTitle("Button \(index)", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
            button.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)

            // Size and position button.
            button.sizeToFit()
            button.frame = CGRect(x: xPos, y: 0, width: button.frame.size.width, height: 44)
            xPos += button.frame.size.width

            // Add to view.
            aview.addSubview(button)
        }

        aview.contentSize = CGSize(width: xPos, height: 44)
        aview.backgroundColor = UIColor.green
        topItem?.titleView = aview
    }

}

//
//  OLScrollingNavBar.swift
//  Navigation Controller
//
//  Created by Brandon Outlaw on 10/19/16.
//  Copyright © 2016 Goldstar Events, Inc. All rights reserved.
//

import UIKit

class OLScrollingNavBar: UIScrollView {

    var barItems: [String] = [] {
        didSet {
            self.updateItems()
        }
    }

    func updateItems() {
        var xPos: CGFloat = 0

        for (index, item) in barItems.enumerated() {
            // Initialize and configure button.
            let button = UIButton(type: .custom)
            let color: CGFloat = (CGFloat(index) * CGFloat(20)) / 255.0
            button.setTitle(item, for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
            button.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)

            // Size and position button.
            button.sizeToFit()
            button.frame = CGRect(x: xPos, y: 0, width: button.frame.size.width, height: 44)
            xPos += button.frame.size.width

            // Add to view.
            addSubview(button)
        }

        contentSize = CGSize(width: xPos, height: 44)
        backgroundColor = UIColor.green
    }

    override var frame: CGRect {
        didSet {
            guard let size = superview?.frame.size else { return }
            super.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showsHorizontalScrollIndicator = false
    }

}

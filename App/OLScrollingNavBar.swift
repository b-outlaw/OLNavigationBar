//
//  OLScrollingNavBar.swift
//  Navigation Controller
//
//  Created by Brandon Outlaw on 10/19/16.
//  Copyright © 2016 Goldstar Events, Inc. All rights reserved.
//

import UIKit

class OLScrollingNavBar: UIScrollView {

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

//
//  OLScrollingNavBar.swift
//  Navigation Controller
//
//  Created by Brandon Outlaw on 10/19/16.
//  Copyright © 2016 Goldstar Events, Inc. All rights reserved.
//

import UIKit

protocol OLScrollingNavBarDelegate {
    func navBarItemSelected()
}

private extension Selector {
    static let navBarItemSelected = #selector(OLScrollingNavBar.navBarItemSelected)
}

class OLScrollingNavBar: UIScrollView {

    struct Configuration {
        var backgroundColor: UIColor = .red
        var textColor: UIColor = .white
        var horizontalInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
    }

    var scrollingNavBarDelegate: OLScrollingNavBarDelegate?

    var barItems: [String] = [] {
        didSet {
            self.updateItems()
        }
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

    func navBarItemSelected() {
        scrollingNavBarDelegate?.navBarItemSelected()
    }
}

private extension OLScrollingNavBar {
    func updateItems() {
        var xPos: CGFloat = 0

        for (_, item) in barItems.enumerated() {
            // Initialize and configure button.
            let button = UIButton(type: .custom)
            button.setTitle(item, for: .normal)
            button.setTitleColor(Configuration().textColor, for: .normal)
            button.contentEdgeInsets = Configuration().horizontalInsets
            button.backgroundColor = Configuration().backgroundColor
            button.addTarget(self, action: .navBarItemSelected, for: .touchUpInside)

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
}

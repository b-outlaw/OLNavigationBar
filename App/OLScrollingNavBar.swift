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
        var backgroundColor: UIColor = .clear
        var textColor: UIColor = .white
        var horizontalInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
    }
    var config = Configuration()

    var scrollingNavBarDelegate: OLScrollingNavBarDelegate?

    var barItems: [String] = [] {
        didSet {
            self.updateItems()
        }
    }

    var buttons: [UIButton] = []

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

    func navBarItemSelected(sender: UIButton) {
        buttons.forEach({$0.isSelected = false})
        sender.isSelected = true
        scrollingNavBarDelegate?.navBarItemSelected()
    }
}

private extension OLScrollingNavBar {
    func updateItems() {
        var xPos: CGFloat = 0

        for (_, item) in barItems.enumerated() {
            // Initialize and configure button.
            let button = createButton(withTitle: item)
            button.addTarget(self, action: .navBarItemSelected, for: .touchUpInside)

            // Size and position button.
            button.sizeToFit()
            button.frame = CGRect(x: xPos, y: 0, width: button.frame.size.width, height: 44)
            xPos += button.frame.size.width

            // Add to view.
            addSubview(button)
            buttons.append(button)
        }

        contentSize = CGSize(width: xPos, height: 44)
    }

    func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(config.textColor, for: .normal)
        button.setTitleColor(.purple, for: .highlighted)
        button.setTitleColor(.purple, for: .selected)
        button.contentEdgeInsets = config.horizontalInsets
        button.backgroundColor = config.backgroundColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        return button
    }
}

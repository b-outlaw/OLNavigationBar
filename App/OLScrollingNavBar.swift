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

private extension UIButton {
    func configure(_ theme: OLScrollingNavBar.Theme?) {
        guard let theme = theme else { return }
        setTitleColor(theme.normalTextColor, for: .normal)
        setTitleColor(theme.activeTextColor, for: .selected)
        titleLabel?.font = theme.font
        contentEdgeInsets = theme.horizontalInsets
        backgroundColor = theme.backgroundColor
    }
}

class OLScrollingNavBar: UIScrollView {

    /**
        Theme related data.
    */
    struct Theme {
        var backgroundColor: UIColor
        var normalTextColor: UIColor
        var activeTextColor: UIColor
        var horizontalInsets: UIEdgeInsets
        var font: UIFont

        init(withDictionary dictionary: Dictionary<String,AnyObject>) {
            backgroundColor = dictionary["backgroundColor"] as? UIColor ?? .clear
            normalTextColor = dictionary["normalTextColor"] as? UIColor ?? .black
            activeTextColor = dictionary["activeTextColor"] as? UIColor ?? .black
            font = dictionary["font"] as? UIFont ?? UIFont.systemFont(ofSize: 12)
            if let insets = dictionary["horizontalInsets"] as? NSValue {
                horizontalInsets = insets.uiEdgeInsetsValue
            } else {
                horizontalInsets = .zero
            }
        }
    }

    var themeConfig: Theme? {
        didSet { buttons.forEach({ $0.configure(themeConfig) }) }
    }

    /**
        Class properties.
     */
    var buttons: [UIButton] = []
    var scrollingNavBarDelegate: OLScrollingNavBarDelegate?
    var barItems: [String] = [] {
        didSet { self.updateItems() }
    }

    /**
        Override UINavigationBar's setting of its titleView frame.
        http://stackoverflow.com/a/9925049
     */
    override var frame: CGRect {
        didSet {
            guard let size = superview?.frame.size else { return }
            super.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.updateItems()
        }
    }

    /**
        Initialization methods.
     */
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
        subviews.forEach({$0.removeFromSuperview()})
        buttons.removeAll()

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

        xPos = max((superview?.frame.size.width ?? 0)+1, xPos)
        contentSize = CGSize(width: xPos, height: 44)
    }

    func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.configure(themeConfig)
        return button
    }
}

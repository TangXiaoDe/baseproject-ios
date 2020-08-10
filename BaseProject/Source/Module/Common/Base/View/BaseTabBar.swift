//
//  BaseTabBar.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/26.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBar {

    fileprivate var oldSafeAreaInsets: UIEdgeInsets = UIEdgeInsets.zero

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Custom user interface
    func initialize() {
        setBar()
    }

    func setBar() {
        self.barTintColor = UIColor.white
    }

    override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
            if self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
                self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
                self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
                self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom {
                self.oldSafeAreaInsets = self.safeAreaInsets
                self.invalidateIntrinsicContentSize()
                self.superview?.setNeedsLayout()
                self.superview?.layoutSubviews()
            }
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var s = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            let bottomInset = self.safeAreaInsets.bottom
            if bottomInset > 0 && s.height < 50 {
                s.height += bottomInset
            }
        }
        return s
    }

}

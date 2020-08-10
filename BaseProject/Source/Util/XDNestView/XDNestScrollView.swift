//
//  XDNestScrollView.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/3/4.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  嵌套的可同时滚动的ScrollView
//  允许手势和事件通过的UIScrollView

import UIKit
import WebKit

typealias XDNestingScrollableScrollView = XDNestScrollView
typealias XDNestingScrollScrollView = XDNestScrollView
class XDNestScrollView: UIScrollView {

    // WebView/UIScrollView
    var allowViews: [UIView] = []

    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func commonInit() -> Void {
        // 在某些情况下，contentView中的点击事件会被panGestureRecognizer拦截，导致不能响应，
        // 这里设置cancelsTouchesInView表示不拦截
        self.panGestureRecognizer.cancelsTouchesInView = false
    }

}

// MARK: - <UIGestureRecognizerDelegate>
extension XDNestScrollView: UIGestureRecognizerDelegate {

    // 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard var view = otherGestureRecognizer.view else {
            return false
        }
        if let superView = view.superview, superView.isKind(of: WKWebView.self) {
            view = superView
        }

        let flag: Bool = self.allowViews.contains(view)
        return flag
    }

}

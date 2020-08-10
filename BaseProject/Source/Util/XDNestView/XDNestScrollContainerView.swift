//
//  XDNestScrollContainerView.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/3/4.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  嵌套滚动的容器
//  [注1] 容器内布局 必须使用容器container;
//  [注2] 容器内滚动视图必须添加到容container内的允许视图属性数组中；
//  [注3] 容器内滚动视图必须处理
//  TODO: - 使用原生约束方式出现异常，导致不能正常显示，待解决。具体可参考ChainOneKit库

import UIKit

protocol XDNestScrollContainerViewProtocol: class {

    // 当内容可以滚动时会调用
    func nestingViewContentCanScroll(_ nestView: XDNestScrollContainerView) -> Void

    // 当容器可以滚动时会调用
    func nestingViewContainerCanScroll(_ nestView: XDNestScrollContainerView) -> Void

    // 当容器正在滚动时调用，参数scrollView就是充当容器
    func nestingViewDidContainerScroll(_ scrollView: UIScrollView) -> Void

}

/// 嵌套滚动的容器，容器内布局 必须使用容器container
class XDNestScrollContainerView: UIView {

    let container: XDNestScrollView = XDNestScrollView()

    var containerScrollHeight: CGFloat = 250

    weak var delegate: XDNestScrollContainerViewProtocol?

    var canScroll: Bool = true {
        didSet {
            if canScroll {
                self.delegate?.nestingViewContainerCanScroll(self)
            }
        }
    }

    // WebView/UIScrollView
    var allowViews: [UIView] = [] {
        didSet {
            self.container.allowViews = allowViews
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
    }

}
extension XDNestScrollContainerView {
    func initialUI() -> Void {

        if #available(iOS 11.0, *) {
            self.container.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.addSubview(self.container)
        self.container.delegate = self
        self.container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        let topConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.container, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
//        let leadingConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.container, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
//        let trailingConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.container, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
//        let bottomConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.container, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
//        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}

extension XDNestScrollContainerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let containerScrollHeight = self.containerScrollHeight
        if !self.canScroll {
            // 不可滚动，通过固定contentOffset的值来实现
            scrollView.contentOffset = CGPoint.init(x: 0, y: containerScrollHeight)
        } else {
            //
            if scrollView.contentOffset.y >= containerScrollHeight {
                scrollView.contentOffset = CGPoint.init(x: 0, y: containerScrollHeight)
                self.canScroll = false
                // 通知代理 内容可以滚动
                self.delegate?.nestingViewContentCanScroll(self)
            }
        }
        self.delegate?.nestingViewDidContainerScroll(self.container)
    }

}

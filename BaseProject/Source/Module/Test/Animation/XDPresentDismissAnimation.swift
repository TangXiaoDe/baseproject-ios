//
//  XDPresentDismissAnimation.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/4.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Present与Dismiss动画

import Foundation

enum XDPresentDismissAnimationType {
    case present
    case dismiss
}

class XDPresentDismissAnimation: NSObject {

    let type: XDPresentDismissAnimationType

    init(type: XDPresentDismissAnimationType) {
        self.type = type
        super.init()
    }

}

extension XDPresentDismissAnimation: UIViewControllerAnimatedTransitioning {
    // 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }

    // 具体动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        let fromContextView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toContextView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        //let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        //let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //fromView = fromVC?.view
        //toView = toVC?.view

        guard let fromView = fromContextView, let toView = toContextView else {
            return
        }

        self.presentDismissAnimation(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
    }




}

extension XDPresentDismissAnimation {

    func presentDismissAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {
        // 从左到右
        self.leftToRightAnimation(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
    }

    func leftToRightAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {

        let transView: UIView
        let startFrame: CGRect
        let endFrame: CGRect
        switch self.type {
        case .present:
            transView = toView
            containerView.addSubview(toView)
            startFrame = CGRect.init(x: -kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
            endFrame = UIScreen.main.bounds
        case .dismiss:
            transView = fromView
            containerView.insertSubview(toView, belowSubview: fromView)
            startFrame = UIScreen.main.bounds
            endFrame = CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        }
        transView.frame = startFrame
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            transView.frame = endFrame
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    func rightToLeftAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {

    }

    func topToBottomAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {

    }

    func bottomToTopAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {

    }

}

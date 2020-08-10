//
//  XDPushAnimation.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Push动画

import Foundation
import UIKit


// Push动画
class XDPushAnimation: NSObject {

}

// 转场动画
extension XDPushAnimation: UIViewControllerAnimatedTransitioning {
    /// 转场动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }

    /// 转场动画
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

        self.pushAnimation(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
    }

}

extension XDPushAnimation {

    fileprivate func pushAnimation(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {
        // 从左滑到右
//        self.pushAnimationLeftToRight(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
        // 从右滑到左
        self.pushAnimationRightToLeft(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
        // 从上滑到下
//        self.pushAnimationTopToBottom(containerView: containerView, fromView: fromView, toView: toView, transitionContext: transitionContext)
        // 从下滑到上
        // 其他

        // from动画
        // to动画


    }

    // 从左滑到右
    // 从左滑到右1：fromView 从左向右移除屏幕
    // 从左滑到右2：toView   从左向右进入屏幕
    fileprivate func pushAnimationLeftToRight(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {
        //这个非常重要，将toView加入到containerView中，并注意与fromView的层级
        containerView.insertSubview(toView, belowSubview: fromView)
        // 动画: fromView从左向右移动滑出屏幕
        fromView.frame = UIScreen.main.bounds
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        }) { (finish) in
            // 动画结束 转场结束
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    // 从右滑到左
    fileprivate func pushAnimationRightToLeft(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {
        //这个非常重要，将toView加入到containerView中，并注意与fromView的层级
        containerView.insertSubview(toView, aboveSubview: fromView)
        // 动画: toView再从右向左滑动覆盖fromView
        toView.frame = CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toView.frame = UIScreen.main.bounds
        }) { (finish) in
            // 动画结束 转场结束
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    // 从上滑到下
    fileprivate func pushAnimationTopToBottom(containerView: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) -> Void {
        //这个非常重要，将toView加入到containerView中，并注意与fromView的层级
        containerView.insertSubview(toView, belowSubview: fromView)
        // 动画: fromView从上向下移动滑出屏幕
        fromView.frame = UIScreen.main.bounds
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        }) { (finish) in
            // 动画结束 转场结束
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }


}

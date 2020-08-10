//
//  XDPresentationController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/4.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation

/**
 * 实现自定义过渡动画：
 * 1.继承UIPresentationController 成为子类
 * 2.遵守UIViewControllerAnimatedTransitioning 协议
 * 其实也可以写成两个类，分别继承UIPresentationController和实现UIViewControllerAnimatedTransitioning协议
 */
//我们的 UIPresentationController 的子类是负责「被呈现」及「负责呈现」的 controller 以外的 controller 的
//看着很绕口，说白了，在我们的例子中，它负责的仅仅是那个带渐变效果的黑色半透明背景 View。
//而 UIViewControllerAnimatedTransitioning 类将会负责「被呈现」的 ViewController 的过渡动画
class XDPresentationController: UIPresentationController {

    fileprivate var dimmingView: UIView?

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom
        presentedViewController.modalPresentationStyle = .custom
    }

    // 呈现过渡即将开始的时候被调用的。可以在此方法创建和设置自定义动画所需的view
    override func presentationTransitionWillBegin() {
        print("XDPresentationController presentationTransitionWillBegin")

        guard let containerView = self.containerView else {
            return
        }

        // 背景遮罩
        let dimmingView = UIView.init(frame: containerView.bounds)
        containerView.addSubview(dimmingView)       // 添加到动画容器View中
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false    // 是否透明
        //dimmingView.autoresizingMask = UIView.AutoresizingMask.init(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        dimmingView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dimmingViewTaped)))
        self.dimmingView = dimmingView

        // 获取presentingViewController 的转换协调器，
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        // 动画期间，同步自定义动画
        self.dimmingView?.alpha = 0.0
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView?.alpha = 0.4
        }, completion: nil)

    }

    // 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print("XDPresentationController presentationTransitionDidEnd")

        // Remove the dimmingView view if the presentation was aborted.
        // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
        if (!completed) {
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
        }
    }

    // 消失过渡即将开始的时候被调用的
    override func dismissalTransitionWillBegin() {
        print("XDPresentationController dismissalTransitionWillBegin")

        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) -> Void in
            self.dimmingView?.alpha = 0.0
        }, completion: nil)

    }

    // 消失过渡完成之后调用，此时应该将视图移除，防止强引用
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print("XDPresentationController dismissalTransitionDidEnd")

        if completed {
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
        }
    }

    /// 背景遮罩点击
    @objc fileprivate func dimmingViewTaped() -> Void {
        print("XDPresentationController dimmingViewTaped")
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }


    //| --------以下四个方法，是按照苹果官方Demo里的，都是为了计算目标控制器View的frame的----------------
    //  当 presentation controller 接收到
    //  -viewWillTransitionToSize:withTransitionCoordinator: message it calls this
    //  method to retrieve the new size for the presentedViewController's view.
    //  The presentation controller then sends a
    //  -viewWillTransitionToSize:withTransitionCoordinator: message to the
    //  presentedViewController with this size as the first argument.
    //
    //  Note that it is up to the presentation controller to adjust the frame
    //  of the presented view controller's view to match this promised size.
    //  We do this in -containerViewWillLayoutSubviews.
    //
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let containerVC = container as? UIViewController, containerVC == self.presentedViewController {
            return self.presentedViewController.preferredContentSize
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }

    //在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，
    //被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。
    //我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewBounds = self.containerView?.bounds ?? UIScreen.main.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)

        // The presented view extends presentedViewContentSize.height points from
        // the bottom edge of the screen.
        var presentedViewControllerFrame = containerViewBounds
        presentedViewControllerFrame.size.height = presentedViewContentSize.height
        presentedViewControllerFrame.origin.y = containerViewBounds.size.height - presentedViewContentSize.height
        return presentedViewControllerFrame
    }

    //  This method is similar to the -viewWillLayoutSubviews method in
    //  UIViewController.  It allows the presentation controller to alter the
    //  layout of any custom views it manages.
    //
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.dimmingView?.frame = self.containerView?.bounds ?? UIScreen.main.bounds
    }

    //  This method is invoked whenever the presentedViewController's
    //  preferredContentSize property changes.  It is also invoked just before the
    //  presentation transition begins (prior to -presentationTransitionWillBegin).
    //  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
    //  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if let containerVC = container as? UIViewController, containerVC == self.presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }

}


extension XDPresentationController: UIViewControllerTransitioningDelegate {

    /// 来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了self
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }

    /// 返回的对象控制Presented时的动画 (开始动画的具体细节负责类)
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    /// 返回的控制器控制dismissed时的动画 (结束动画的具体细节负责类)
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    // 指定交互式present动画的控制类
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    // 指定交互式dismiss动画的控制类
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

}


extension XDPresentationController: UIViewControllerAnimatedTransitioning {
    // 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        var duration: TimeInterval = 0.0
        if let context = transitionContext, context.isAnimated {
            duration = 5.5
        }
        return duration
    }

    // 动画效果的实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("XDPresentationController UIViewControllerAnimatedTransitioning animateTransition")

        let containerView = transitionContext.containerView

        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        let fromContextView = transitionContext.view(forKey: UITransitionContextViewKey.from)
//        let toContextView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromContextView = fromVC?.view
        let toContextView = toVC?.view

        // 注：使用toVC?.view方式获取toView时，custom方式，则dimiss时无需添加toView，否则结束时异常；
        //    因这里UITransitionContextViewKey方式获取不到
        guard let fromView = fromContextView, let toView = toContextView else {
            return
        }

        let presentEndFrame: CGRect = CGRect.init(x: 0, y: 0, width: kScreenWidth - 100, height: kScreenHeight)
        let dismissEndFrame: CGRect = CGRect.init(x: -kScreenWidth + 100, y: 0, width: kScreenWidth - 100, height: kScreenHeight)

        //let fromViewEndFrame = transitionContext.finalFrame(for: fromVC!)    // 移动到指定位置
        //let toViewEndFrame = transitionContext.finalFrame(for: toVC!)    // 移动到指定位置

        // 判断是present 还是 dismiss
        let isPresenting = (fromVC == self.presentingViewController)
        if isPresenting {
            containerView.addSubview(toView)
            toView.frame = CGRect.init(x: -kScreenWidth + 100, y: 0, width: kScreenWidth - 100, height: kScreenHeight)
        } else {
            //containerView.insertSubview(toView, belowSubview: fromView)
        }
        // 动画
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            if isPresenting {
                toView.frame = presentEndFrame
            } else {
                fromView.frame = dismissEndFrame
            }
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }

}

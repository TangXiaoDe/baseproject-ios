//
//  TestDismissInteractiveController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestDismissInteractiveController: BaseViewController {
    var interactiveTransition: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.yellow

        // panGR
        let panGR = UIPanGestureRecognizer.init(target: self, action: #selector(panGRProcess(_:)))
        self.view.addGestureRecognizer(panGR)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.transitioningDelegate = nil
        self.transitioningDelegate = self
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.dismiss(animated: true, completion: nil)
//    }


}

extension TestDismissInteractiveController {
    //  2、触发转场动画，通过手势产生百分比数值，更新转场动画状态：
    @objc fileprivate func panGRProcess(_ panGR: UIPanGestureRecognizer) -> Void {
        // 产生百分比
        var progress = panGR.translation(in: self.view).x / kScreenWidth
        progress = min(1.0, max(0.0, progress))

        print("TestDismissInteractiveController panGRProcess translation \(panGR.translation(in: self.view))")
        print("TestDismissInteractiveController panGRProcess \(progress)")

        switch panGR.state {
        case .began:
            self.interactiveTransition = UIPercentDrivenInteractiveTransition.init()
            // 触发转场动画
            self.dismiss(animated: true, completion: nil)
        case .changed:
            self.interactiveTransition?.update(progress)
        case .ended:
            fallthrough
        case .cancelled:
            if progress > 0.5 {
                self.interactiveTransition?.finish()
            } else {
                self.interactiveTransition?.cancel()
            }
            self.interactiveTransition = nil
        default:
            break
        }
    }

}

extension TestDismissInteractiveController: UIViewControllerTransitioningDelegate {
    //指定present动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = XDPresentDismissAnimation.init(type: .present)
        return transition
    }
    //指定dismiss动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = XDPresentDismissAnimation.init(type: .dismiss)
        return transition
    }

    // 指定交互式present动画的控制类
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    // 指定交互式dismiss动画的控制类
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveTransition
    }

}

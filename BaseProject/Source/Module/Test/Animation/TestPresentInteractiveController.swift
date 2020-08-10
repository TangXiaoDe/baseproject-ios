//
//  TestPresentInteractiveController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestPresentInteractiveController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.red
        self.navigationItem.title = "PresentInteractive"


    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextVC = TestDismissInteractiveController()
        nextVC.transitioningDelegate = self
        self.present(nextVC, animated: true, completion: nil)
    }

}

extension TestPresentInteractiveController: UIViewControllerTransitioningDelegate {
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
        return nil
    }

}

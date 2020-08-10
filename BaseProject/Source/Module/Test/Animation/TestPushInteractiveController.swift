//
//  TestPushInteractiveController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Interactive可交互的

import UIKit

///
class TestPushInteractiveController: BaseViewController {

    var interactiveTransition: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.red
        self.navigationItem.title = "InteractivePush"


        // 添加pan手势
        let panGR = UIPanGestureRecognizer.init(target: self, action: #selector(panGRProcess(_:)))
        self.view.addGestureRecognizer(panGR)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isKind(of: UINavigationControllerDelegate.self) {
            self.navigationController?.delegate = nil
        }
    }


    fileprivate func enterNextPage() -> Void {
        let nextVC = TestPopInteractiveController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


}



extension TestPushInteractiveController: UINavigationControllerDelegate {

    // 谁提供动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == UINavigationController.Operation.push) {
            return XDPushAnimation()
        }
        return nil
    }

    // 谁控制动画
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        //        if animationController.isKind(of: TestPushInteractiveController) {
        //            return self.interactivePopTransition
        //        } else {
        //            return nil
        //        }

        return self.interactiveTransition
    }

}

extension TestPushInteractiveController {
    //  2、触发转场动画，通过手势产生百分比数值，更新转场动画状态：
    @objc fileprivate func panGRProcess(_ panGR: UIPanGestureRecognizer) -> Void {
        // 产生百分比
        var progress = panGR.translation(in: self.view).x / kScreenWidth
        progress = min(1.0, max(0.0, progress))
        progress = 1.0 - progress

        print("TestPushInteractiveController panGRProcess \(progress)")

        switch panGR.state {
        case .began:
            self.interactiveTransition = UIPercentDrivenInteractiveTransition.init()
            // 触发转场动画
            self.enterNextPage()
        case .changed:
            self.interactiveTransition?.update(progress)
        case .ended:
            fallthrough
        case .cancelled:
            if progress < 0.5 {
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

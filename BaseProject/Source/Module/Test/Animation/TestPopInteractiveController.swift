//
//  TestPopInteractiveController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Interactive可交互的

import UIKit

class TestPopInteractiveController: BaseViewController {

    var interactivePopTransition: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.yellow
        self.navigationItem.title = "InteractivePop"


        // 1、添加pan手势
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

}

extension TestPopInteractiveController: UINavigationControllerDelegate {

    // 谁来提供动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == UINavigationController.Operation.pop) {
            return XDPopAnimation()
        }
        return nil
    }

    // 谁来控制动画
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

//        if animationController.isKind(of: TestPushInteractiveController) {
//            return self.interactivePopTransition
//        } else {
//            return nil
//        }

        return self.interactivePopTransition
    }

}

extension TestPopInteractiveController {
    //  2、触发转场动画，通过手势产生百分比数值，更新转场动画状态：
    @objc fileprivate func panGRProcess(_ panGR: UIPanGestureRecognizer) -> Void {
        // 产生百分比
        var progress = panGR.translation(in: self.view).x / kScreenWidth
        progress = min(1.0, max(0.0, progress))

        switch panGR.state {
        case .began:
            self.interactivePopTransition = UIPercentDrivenInteractiveTransition.init()
            // 触发转场动画
            self.navigationController?.popViewController(animated: true)
        case .changed:
            self.interactivePopTransition?.update(progress)
        case .ended:
            fallthrough
        case .cancelled:
            if progress > 0.5 {
                self.interactivePopTransition?.finish()
            } else {
                self.interactivePopTransition?.cancel()
            }
            self.interactivePopTransition = nil
        default:
            break
        }
    }

}

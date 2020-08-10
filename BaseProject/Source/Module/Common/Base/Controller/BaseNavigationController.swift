//
//  BaseNavigationController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/28.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.interactivePopGestureRecognizer?.delegate = self
    }

    // MARK: - Push时导航栏左侧按钮和底部tabbar处理
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !self.viewControllers.isEmpty {
            let backBarItem = UIBarButtonItem(image: UIImage(named: "IMG_navbar_back"), style: .plain, target: self, action: #selector(leftPopBackItemClick))
            viewController.navigationItem.leftBarButtonItem = backBarItem
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    @objc func leftPopBackItemClick() {
        self.popViewController(animated: true)
    }

//    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        // 判断是否是根控制器
//        return self.children.count > 1
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

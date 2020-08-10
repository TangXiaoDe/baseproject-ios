//
//  TestPresentationController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestPresentationController: BaseViewController {

    var controller: XDPresentationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.red
        self.navigationItem.title = "Present"


    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        //        let nextVC = TestDismissController()
        //        nextVC.transitioningDelegate = self
        //        // 指定为overCurrentContext、overFullScreen、custom 时 动画方式不可present，非动画方式可行。
        //        nextVC.modalPresentationStyle = .overCurrentContext
        //        // 不响应
        //        //nextNC.modalPresentationStyle = .overCurrentContext
        //        //nextNC.modalPresentationStyle = .overFullScreen
        //        //nextNC.modalPresentationStyle = .custom
        //
        //        // 响应但不透明
        //        //nextNC.modalPresentationStyle = .currentContext
        //        //nextNC.modalPresentationStyle = .fullScreen
        //        //nextNC.modalPresentationStyle = .pageSheet
        //        //nextNC.modalPresentationStyle = .formSheet
        //        //nextNC.modalPresentationStyle = .popover
        //
        //        // 崩溃
        //        //nextNC.modalPresentationStyle = .none
        //        self.present(nextVC, animated: true, completion: nil)



//        let nextVC = TestDismissionController()
//        let presentationController = XDPresentationController.init(presentedViewController: nextVC, presenting: self)
//        self.controller = presentationController
//        nextVC.transitioningDelegate = presentationController
//        self.present(nextVC, animated: true, completion: nil)


        let nextVC = TestDismissionController()
        let nextNC = BaseNavigationController.init(rootViewController: nextVC)
        let presentationController = XDPresentationController.init(presentedViewController: nextNC, presenting: self)
        nextNC.transitioningDelegate = presentationController
        self.present(nextNC, animated: true, completion: nil)

    }

}

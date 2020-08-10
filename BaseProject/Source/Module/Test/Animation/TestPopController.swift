//
//  TestPopController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestPopController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.yellow
        self.navigationItem.title = "Pop"
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


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }


}


extension TestPopController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == UINavigationController.Operation.pop) {
            return XDPopAnimation()
        }
        return nil
    }

}

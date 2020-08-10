//
//  TestDismissionController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestDismissionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orange

        self.updatePreferredContentSize(with: self.traitCollection)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
        print("TestDismissionController touchesBegan")
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        // When the current trait collection changes (e.g. the device rotates), update the preferredContentSize.
        self.updatePreferredContentSize(with: newCollection)
    }

    /// Updates the receiver's preferredContentSize based on the verticalSizeClass of the provided \a traitCollection.
    fileprivate func updatePreferredContentSize(with traitCollection: UITraitCollection) -> Void {
        let contentSize = CGSize.init(width: kScreenWidth - 100, height: kScreenHeight)
        self.preferredContentSize = contentSize
    }


}

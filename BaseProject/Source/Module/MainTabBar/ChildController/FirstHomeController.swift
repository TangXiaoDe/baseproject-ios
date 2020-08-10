//
//  FirstHomeController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class FirstHomeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(leftBarItemClick))

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc fileprivate func leftBarItemClick() -> Void {

        // 发送通知 弹出左侧弹窗
        NotificationCenter.default.post(name: Notification.Name.App.showLeftMenu, object: nil)

    }

}

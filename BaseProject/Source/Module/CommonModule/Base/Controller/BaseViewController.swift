//
//  BaseViewController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  项目中的控制器基类

import UIKit

class BaseViewController: UIViewController {

    /// 当前界面是否正在展示
    var isAppearing: Bool = false

    var appearTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.pageBg
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isAppearing = true
        self.appearTime += 1
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isAppearing = false
    }



    /// navpush子界面
    func enterPageVC(_ pageVC: UIViewController) -> Void {
        self.navigationController?.pushViewController(pageVC, animated: true)
    }
    /// pushi进入子界面
    func pushEnterPage(_ pageVC: UIViewController) -> Void {
        self.navigationController?.pushViewController(pageVC, animated: true)
    }

    // MARK: - 提供进入常见页面的方法(基类方法名添加push做到见名知义)

    /// 进入用户主页
    func pushEnterUserHomePage(id: Int) -> Void {
//        let homeVC = UserHomeController.init(userId: id)
//        self.pushEnterPage(homeVC)
    }
    /// 进入用户资料页
    func pushEnterUserInfoPage(id: Int) -> Void {
//        let infoVC = UserInfoController.init(userId: id)
//        self.pushEnterPage(infoVC)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

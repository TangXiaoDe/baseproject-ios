//
//  LaunchController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  启动页 -
//  1. 加载 LaunchScreen.storyboard 作为启动展示界面；
//  2. 指定时间进行延迟加载，到期后根据情况自动进入对应的页面；

import UIKit

/// 启动页
class LaunchController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    /// 延迟加载时间
    fileprivate var duration: Double = 2.0

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension LaunchController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

// MARK: - UI
extension LaunchController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.white
        // 加载LaunchScreen.sb
        self.loadLaunchScreenSB()
    }

    // 加载LaunchScreen.sb
    fileprivate func loadLaunchScreenSB() -> Void {
        let sb: UIStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        if let vc = sb.instantiateInitialViewController() {
            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.view.backgroundColor = UIColor.clear
            vc.view.frame = self.view.bounds
        }
    }

}

// MARK: - Data(数据处理与加载)
extension LaunchController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        // 添加延迟切换
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.duration) {
            let isFirst: Bool = AppConfig.share.internal.isFirstEnter
            if AppConfig.share.showTest {
                self.enterTestPage()
            } else {
//                self.gotoNextPage(isFirst: isFirst)
                RootManager.share.type = .advert
            }
            if isFirst {
                VersionManager.share.updateSavedVersion()
            }
        }
    }

    /// 进入下一个界面
    fileprivate func gotoNextPage(isFirst: Bool) -> Void {
        // 第一次，则进入引导页 > 非点击通知启动且有启动广告时进入广告页 > 已登录则进入主页 > 进入登录页
        let hasAdverts: Bool = !DataBaseManager().advert.getAdverts(for: AdvertSpaceType.boot).isEmpty
        let isLogined: Bool = AccountManager.share.isLogin
        if isFirst {
            RootManager.share.type = .guide
        } else if LaunchType.remote != AppConfig.share.internal.launch && hasAdverts {
            RootManager.share.type = .advert
        } else if isLogined {
            RootManager.share.type = .main
            //AppUtil.updateCurrentUserInfo()
        } else {
            RootManager.share.type = .login
        }
    }

}

extension LaunchController {
    /// 进入测试页
    fileprivate func enterTestPage() -> Void {
        let testVC = TestHomeController()
        let rootNC = BaseNavigationController.init(rootViewController: testVC)
        UIApplication.shared.keyWindow?.rootViewController = rootNC
    }

}

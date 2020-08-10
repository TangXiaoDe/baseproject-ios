//
//  MainTabBarController+Extension.swift
//  BaseProject
//
//  Created by 小唐 on 2020/8/10.
//  Copyright © 2020 ChainOne. All rights reserved.
//

import Foundation


// MARK: - extension
extension MainTabBarController {
    /// 双击tabbar滚动
    func doubleSelectTabbar() {
        //发送双击tabbar通知
        NotificationCenter.default.post(name: NSNotification.Name.Tabbar.doubleTap, object: nil, userInfo: nil)
    }
}


// MARK: - 
extension MainTabBarController {
    
    /// 网络环境变更通知处理
    @objc fileprivate func reachabilityChangedNotificationProcess(_ notification: Notification) -> Void {
        print("MainTabBarController reachabilityChangedNotificationProcess")
        guard let conn = notification.object as? AppReachability.Connection else {
            return
        }
        switch conn {
        case .wifi:
            break
        case .cellular:
            break
        case .none:
            print("MainTabBarController reachabilityChangedNotificationProcess reach.connection none")
            // 提示网络设置
            AppUtil.showNetworkSettingAlert()
        }
    }

    /// 显示左侧弹窗通知处理
    @objc fileprivate func showLeftMenuNotificationProcess(_ notification: Notification) -> Void {
//        self.showLeftMenu(interactive: false)
    }

    /// 401 token过期弹窗提示处理
    @objc fileprivate func authenticationIllicitNotificationProcess(_ notification: Notification) -> Void {
        if RootManager.share.authIllicitAlertShowing {
            return
        }
        AppUtil.logoutProcess(isAuthValid: false, isSwitchLogin: false)
        RootManager.share.authIllicitAlertShowing = true
        let title: String = "登录失效"
        let alertVC = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            RootManager.share.authIllicitAlertShowing = false
            RootManager.share.switchRoot(.login)
        }))
        RootManager.share.topRootVC.present(alertVC, animated: true, completion: nil)
        // 5秒之后如果弹窗还没未消失，则自动处理
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
            RootManager.share.authIllicitAlertShowing = false
            alertVC.dismiss(animated: true, completion: {
                RootManager.share.switchRoot(.login)
            })
        }
    }

    /// tabbar点击跳转
    @objc fileprivate func tabbarSwitchNotificationProcess(_ notification: Notification) -> Void {
        switch notification.name {
        case Notification.Name.Tabbar.imeet:
            self.selectedIndex = 0
        case Notification.Name.Tabbar.meet:
            self.selectedIndex = 1
        case Notification.Name.Tabbar.square:
            self.selectedIndex = 2
        case Notification.Name.Tabbar.mining:
            self.selectedIndex = 3
        case Notification.Name.Tabbar.planet:
            self.selectedIndex = AppConfig.share.shield.currentNeedShield ? 3 : 4
        default:
            break
        }
    }

    /// 广告点击
    @objc fileprivate func advertClickNotificationProcess(_ notification: Notification) -> Void {
//        guard let model = notification.object as? AdvertModel else {
//            return
//        }
//        switch model.linkType {
//        case .outside:
//            self.enterAdWebPage(link: model.link)
//        case .inside:
//            break
//        default:
//            break
//        }
    }

    /// 用户点击(头像、用户信息)
    @objc fileprivate func userClickNotificationProcess(_ notification: Notification) -> Void {
//        guard let user = notification.object as? SimpleUserModel, let selectedNC = self.selectedViewController as? UINavigationController else {
//            return
//        }
//        switch notification.name {
//        case Notification.Name.User.click:
//            let userVC = UserInfoController.init(userId: user.id)
//            selectedNC.pushViewController(userVC, animated: true)
//        case Notification.Name.User.ClickForHome:
//            let userVC = UserHomeController.init(userId: user.id)
//            selectedNC.pushViewController(userVC, animated: true)
//        default:
//            break
//        }
    }
    
}

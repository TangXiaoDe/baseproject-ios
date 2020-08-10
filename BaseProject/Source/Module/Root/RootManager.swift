//
//  RootManager.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  根控管理器 - 所有的根控切换都应在这里处理

/**
 根控管理方案：
 方案1：切换window的根控，即修改UIApplication.shared.keyWindow?.rootViewController；
 方案2：切换rootVC下的显示界面，即rootVC唯一，但其下的显示界面动态更换；
 这里采用方案2来实现，注意方案1在多个window下时需特别考虑；
 **/


import Foundation
import UIKit

/// 根控类型
enum RootType {
    /// 启动，同启动页
    case launch
    /// 引导页，不是每次都展示
    case guide
    /// 登录页
    case login
    /// 主页
    case main
}

class RootManager {

    /// 真实的根控
    let rootVC: RootViewController = RootViewController()
    /// 需要显示的根控，切换显示根控请使用type
    fileprivate(set) var showRootVC: UIViewController {
        didSet {
            self.rootVC.showRootVC = showRootVC
        }
    }

    /// 根控类型 - 实际显示的根控类型
    var type: RootType {
        didSet {
            if oldValue == type {
                return
            }
            self.setupRootType(type)
        }
    }

    /// 单例
    static let share = RootManager()
    fileprivate init() {
        self.showRootVC = LaunchController()
        self.rootVC.showRootVC = self.showRootVC
        self.type = RootType.launch
        NotificationCenter.default.addObserver(self, selector: #selector(notificationProcess(_:)), name: NSNotification.Name.App.getSystemConfig, object: nil)
    }

    /// 授权过期弹窗显示中 - 用于tabbar上的授权过期提示，该提示显示时不显示Toast
    var authIllicitAlertShowing: Bool = false

    /// 顶部根控
    var topRootVC: UIViewController {
        var topRootVC: UIViewController = self.showRootVC
        if let presentedVC = self.showRootVC.presentedViewController {
            topRootVC = presentedVC
        }
        return topRootVC
    }

}

// MARK: - Internal Function
extension RootManager {
    /// 根控切换
    func switchRoot(_ type: RootType) -> Void {
        self.type = type
        self.authIllicitAlertShowing = false
    }

    /// 显示启动页广告
    func showLaunchAdvert() -> Void {
        // 1. 获取启动广告
        let adverts = DataBaseManager().advert.getAdverts(for: AdvertSpaceType.boot)
        if adverts.isEmpty {
            return
        }
        // 2. 显示启动广告
        let advertView = LaunchAdvertView()
        advertView.models = adverts
        UIApplication.shared.keyWindow?.addSubview(advertView)
        UIApplication.shared.keyWindow?.bringSubviewToFront(advertView)
        advertView.frame = UIScreen.main.bounds
        advertView.starAnimation()
    }

}

// MARK: - Fileprivate Function
extension RootManager {

    /// 跟控设置
    fileprivate func setupRootType(_ type: RootType) -> Void {
        // 当前有present弹窗则退出
        self.showRootVC.presentedViewController?.dismiss(animated: false, completion: nil)
        var rootVC: UIViewController
        switch type {
        case .launch:
            rootVC = LaunchController()
        case .guide:
            rootVC = GuideController()
        case .login:
            rootVC = BaseNavigationController(rootViewController: LoginRegisterController())
        case .main:
            rootVC = MainTabBarController()
        }
        self.showRootVC = rootVC
    }

}

// MARK: - Notification
extension RootManager {

    /// 通知处理
    @objc fileprivate func notificationProcess(_ notification: Notification) -> Void {
        switch notification.name {
        case Notification.Name.App.getSystemConfig:
            AppUtil.getSystemConfig()
        default:
            break
        }
    }

}

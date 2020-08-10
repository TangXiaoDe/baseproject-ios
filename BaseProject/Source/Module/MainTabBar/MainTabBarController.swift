//
//  MainTabBarController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit
import Reachability

class MainTabBarController: UITabBarController {
    // MARK: - Internal Property

    // MARK: - Private Property
    fileprivate var items: [TabbarItemModel] = []

    fileprivate var lastDate = Date.init()


    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Internal Function
extension MainTabBarController {

}

// MARK: - LifeCircle Function
extension MainTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.initialUI()
        self.initialDataSource()

        VersionManager.share.updateProcess()        // 版本更新判断
        AppUtil.updateRealNameCert()              // 实名认证状态更新
        AppUtil.updateUserTotalCT()               // CT数更新
        /// 广告
//        NotificationCenter.default.addObserver(self, selector: #selector(advertClickNotificationProcess(_:)), name: NSNotification.Name.AdvertClick, object: nil)
        // 网络环境配置
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChangedNotificationProcess(_:)), name: NSNotification.Name.imeet.reachabilityChanged, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - UI
extension MainTabBarController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.white
    }
}

// MARK: - Data(数据处理与加载)
extension MainTabBarController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        // items
        let imeetItem = TabbarItemModel(title: "tabbar.imeet".localized, normalImageName: "IMG_tabbar_icon_imeet_normal", selectedImageName: "IMG_tabbar_icon_imeet_selected", childVC: FirstHomeController())
        let meetItem = TabbarItemModel(title: "tabbar.meet".localized, normalImageName: "IMG_tabbar_icon_meet_normal", selectedImageName: "IMG_tabbar_icon_meet_selected", childVC: SecondHomeController())
        //let wakuangItem = TabbarItemModel(title: "tabbar.mining".localized, normalImageName: "IMG_tabbar_icon_wk_normal", selectedImageName: "IMG_tabbar_icon_wk_selected", childVC: MiningHomeController.init(showTabBar: true))
        let taskItem = TabbarItemModel(title: "tabbar.task".localized, normalImageName: "IMG_tabbar_icon_task_normal", selectedImageName: "IMG_tabbar_icon_task_select", childVC: ThirdHomeController.init())
        //let squareItem = TabbarItemModel(title: "tabbar.square".localized, normalImageName: "IMG_tabbar_icon_square_normal", selectedImageName: "IMG_tabbar_icon_square_selected", childVC: SquareHomeController())
        let squareItem = TabbarItemModel(title: "tabbar.square".localized, normalImageName: "IMG_tabbar_icon_square_normal", selectedImageName: "IMG_tabbar_icon_square_selected", childVC: FourthHomeController())
        let planeItem = TabbarItemModel(title: "tabbar.planet".localized, normalImageName: "IMG_tabbar_icon_planet_normal", selectedImageName: "IMG_tabbar_icon_planet_selected", childVC: FifthHomeController())
        if AppConfig.share.shield.currentNeedShield {
            self.items = [imeetItem, meetItem, taskItem, squareItem, planeItem]
        } else {
            self.items = [imeetItem, meetItem, taskItem, squareItem, planeItem]
        }
        self.setupChildControllers()
    }

    /// 加载子控制器
    fileprivate func setupChildControllers() -> Void {
        // customTabbar
        let customTabbar: BaseTabBar = BaseTabBar()
        customTabbar.barTintColor = UIColor.init(hex: 0x2D385C)
        self.setValue(customTabbar, forKey: "tabBar")
        // childs
        var childVCList: [UIViewController] = []
        for item in items {
            let childNC = self.packChildVC(item.childVC, title: item.title, normalImage: item.normalImage, selectedImage: item.selectedImage)
            childVCList.append(childNC)
        }
        // viewControllers 方式
        self.viewControllers = childVCList
        // addChildController方式 多次添加
        // self.addChildViewController(childNC)
        // 默认选中
        self.selectedIndex = 2
        // tabbar上item里的图文间距调整
        customTabbar.setTitleImageInsets(titlePositionOffset: UIOffset.init(horizontal: 0, vertical: -2), imageInsets: UIEdgeInsets.init(top: -1, left: 0, bottom: 1, right: 0))
    }


}

// MARK: - Event(事件响应)
extension MainTabBarController {


}

// MARK: - sync data
extension MainTabBarController {

}

extension MainTabBarController {
    fileprivate func enterAdWebPage(link: String) -> Void {
        let webVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: link))
        if let selectedNC = self.selectedViewController as? UINavigationController {
            selectedNC.pushViewController(webVC, animated: true)
        }
    }

}
// MARK: - Notification
extension MainTabBarController {

    /// 通知统一入口，将子通知放到专门的Extension文件中去处理
    @objc fileprivate func notificationProcess(_ notification: Notification) -> Void {
        switch notification.name {
        case NSNotification.Name.AdvertClick:
            break
        case NSNotification.Name.app.reachabilityChanged:
            break
        default:
            break
        }
    }

}

// MARK: - Extension Function
extension MainTabBarController {
    /// 包装子控制器成为导航控制器
    fileprivate func packChildVC(_ childVC: UIViewController, title: String, normalImage: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        // 注：若tabBarItem.title不显示再tabbar上，确认下tabbarItem对应的VC是否直接是该VC，即是否使用NC包装；
        childVC.navigationItem.title = title
        let childNC: BaseNavigationController = BaseNavigationController(rootViewController: childVC)
        childNC.tabBarItem.title = title
        childNC.tabBarItem.image = normalImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childNC.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childNC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        return childNC
    }
    /// 设置子控制器
    fileprivate func setupChildVC(_ childVC: UIViewController, title: String, normalImage: UIImage?, selectedImage: UIImage?) -> Void {
        // 注：若tabBarItem.title不显示再tabbar上，确认下tabbarItem对应的VC是否直接是该VC，即是否使用NC包装；
        //childVC.title = title
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = normalImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
    }
}

// MARK: - ShowAlert
extension MainTabBarController {

}

// MARK: - EnterPage
extension MainTabBarController {

}

// MARK: - delegate

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let currentDate = Date.init()
//        let nav = tabBarController.selectedViewController as! BaseNavigationController
//        if let firstVC = nav.viewControllers.first, firstVC.isKind(of: MessageHomeController.self) && currentDate.timeIntervalSince1970 - self.lastDate.timeIntervalSince1970 <= 0.5 {
//            self.doubleSelectTabbar()
//        }
//        if let firstVC = nav.viewControllers.first, firstVC.isKind(of: MessageHomeController.self) {
//            self.lastDate = currentDate
//        }
    }

}

// MARK: - Timer & Looping
extension MainTabBarController {

}

// MARK: - Delegate Function


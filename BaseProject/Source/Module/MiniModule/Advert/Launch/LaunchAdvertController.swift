//
//  LaunchAdvertController.swift
//  BaseProject
//
//  Created by 小唐 on 2020/8/10.
//  Copyright © 2020 ChainOne. All rights reserved.
//
//  启动广告界面
//  有启动广告广告则显示，没有则在initialDataSource中切换根控

import UIKit


///  启动广告页显示类型
enum LaunchAdvertShowType {
    case advert     /// 显示广告
    case web        /// 显示广告点击后内容
}

class LaunchAdvertController: BaseViewController
{
    // MARK: - Internal Property
    
    // MARK: - Private Property
    
    fileprivate var type: LaunchAdvertShowType = .advert
    
    fileprivate let advertView: LaunchAdvertView = LaunchAdvertView.init()
    fileprivate var webVC: XDWKWebViewController?
    fileprivate var webNC: BaseNavigationController?

    
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

// MARK: - LifeCircle & Override Function
extension LaunchAdvertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
    
    /// 控制器的view将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    /// 控制器的view即将消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

// MARK: - UI
extension LaunchAdvertController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // 1. advertView
        self.view.addSubview(self.advertView)
        //self.advertView.delegate = self
        self.advertView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - Data(数据处理与加载)
extension LaunchAdvertController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        let adverts = DataBaseManager().advert.getAdverts(for: AdvertSpaceType.boot)
        guard !adverts.isEmpty else {
            self.noAdvertsProcess()
            return
        }
        self.advertView.models = adverts
        self.advertView.starAnimation()
    }
    /// 没有广告时的处理
    fileprivate func noAdvertsProcess() -> Void {
        let isLogined: Bool = AccountManager.share.isLogin
        if isLogined {
            RootManager.share.type = .main
            //AppUtil.updateCurrentUserInfo()
        } else {
            RootManager.share.type = .login
        }
    }
    
    fileprivate func advertClickProcess(_ model: AdvertModel) -> Void {
        if model.linkType == .outside {
            var strUrl = model.link
            if !strUrl.hasPrefix("http://") && !strUrl.hasPrefix("https://") {
                strUrl = "http://" + model.link
            }
            self.showWebAdvert(with: strUrl)
//            let webVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: strUrl))
//            let webNC = BaseNavigationController.init(rootViewController: webVC)
//            RootManager.share.rootVC.present(webNC, animated: false) {
//                self.dismiss()
//            }
        } else if model.linkType == .inside {
            switch model.inLinkType {
            case .none:
                break
            case .activity:
                // 屏蔽账号不进如邀请大赛
                if AppConfig.share.shield.currentNeedShield {
                    return
                }
//                // 进入邀请大赛需要登录
//                if let tabbarVC = RootManager.share.showRootVC as? UITabBarController, let selectedNC = tabbarVC.selectedViewController as? UINavigationController {
//                    let activityVC = InviteActivityHomeController.init(model: nil)
//                    selectedNC.pushViewController(activityVC, animated: true)
//                    self.dismiss()
//                }
            }
        }
    }
    

}

// MARK: - Event(事件响应)
extension LaunchAdvertController {
    
}

// MARK: - Enter Page
extension LaunchAdvertController {
    
}

// MARK: - Notification
extension LaunchAdvertController {
    
}

// MARK: - Extension Function
extension LaunchAdvertController {
    
}

// MARK: - Delegate Function

// MARK: - <>
extension LaunchAdvertController {

    /// 显示网页广告
    fileprivate func showWebAdvert(with strUrl: String) -> Void {
        self.webNC?.view.removeFromSuperview()
        self.type = .web
        let webVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: strUrl))
        let webNC = BaseNavigationController.init(rootViewController: webVC)
        self.addChild(webNC)
        self.view.addSubview(webNC.view)
        webNC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.webVC = webVC
        self.webNC = webNC
    }

}


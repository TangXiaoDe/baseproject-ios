//
//  BaseProjectUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/28.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//
//  TODO: - ProjectUtil的迁移处理

import Foundation
import UIKit
import ObjectMapper
import MBProgressHUD

class AppUtil: NSObject {

    /// 邀请好友复制链接处理
    class func invitePageCopyLink(inviteUrl: String) -> String {
        let strLink: String = "给大家强烈推荐一款区块链用户、社群运营、社区建设人人必备产品：\n\n【链乎】-全球首款区块链社区管理平台\n\n我为链乎带盐！！！\n推荐理由：最接地气，最了解区块链社区，最适合区块链社区建设、社群运营、社群管理，既有区别于微信的IM社交、社区广场，又有区块链专有的任务大厅、趣味挖矿等。\n\n下载狂戳：\(inviteUrl)\n\n自从有了链乎，我再也不用担心社群的无趣了 ，遇见另一个世界的你我~"
        return strLink
    }
//    //字典转模型
//    @objc public static func initWith(json: [String: Any]) -> MessageExtModel? {
//        return MessageExtModel.init(JSON: json)
//    }
    //字典转模型
    @objc public static func initWithUserDict(json: [String: Any]) -> SimpleUserModel? {
        if json == nil {
            return nil
        }
        return SimpleUserModel.init(JSON: json)
    }
    //字典转模型
    @objc public static func initWithUserArray(json: [[String: Any]]) -> [SimpleUserModel]? {
        if json == nil {
            return nil
        }
        let array = Mapper<SimpleUserModel>().mapArray(JSONArray: json)
        return array
    }
//    /// 获取存储的好友模型
//    @objc public static func initWith(friendId: Int) -> FriendModel? {
//        return FriendDBManager().getFriend(friendId: friendId)
//    }

    /// 获取屏蔽设置
    @objc public static func isShield() -> Bool {
        return AppConfig.share.shield.currentNeedShield
    }
}

extension AppUtil {
    /// 复制到粘贴板处理
    class func copyToPasteProcess(_ strCopy: String, indicatorMsg: String) -> Void {
        let paste = UIPasteboard.general
        paste.string = strCopy
        Toast.showToast(title: indicatorMsg)
    }
}

extension AppUtil {
    /// 刷新当前用户信息
    class func refreshCurrentUserInfo(_ complete: (() -> Void)? = nil) -> Void {
//        // 当前用户模型中的认证状态、totalCT都不在用户接口中直接返回，而是单独接口返回，故更新时需注意顺序，否则可能重置。
//        UserNetworkManager.getCurrentUser { (_, _, _) in
//            AppUtil.updateUserTotalCT()
//            AppUtil.updateRealNameCert()
//            if let complete = complete {
//                complete()
//            }
//        }
    }

}

/// hud 显示模块
extension AppUtil {

    static let defaultTimeInterval = 1.5

    /// hud 显示
    class func showHud(text: String? = nil, onView: UIView? = nil, timeInterval: Double? = nil) -> Void {
        var currentView: UIView? = nil
        if let view = onView {
            currentView = view
        } else {
            currentView = UIApplication.shared.keyWindow
        }
        guard let hudOnView = currentView else {
            return
        }
        DispatchQueue.main.async {
            let hud = UIApplication.shared.keyWindow?.viewWithTag(10_000) as? MBProgressHUD
            if let hud = hud {
                hud.show(animated: false)
                if let timeInterval = timeInterval {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: {
                        hud.hide(animated: true)
                    })
                }
            } else {
                let hud = MBProgressHUD.showAdded(to: hudOnView, animated: true)
                hud.contentColor = UIColor.white
                hud.bezelView.style = .solidColor
                hud.backgroundView.backgroundColor = UIColor.init(hex: 0x000000).withAlphaComponent(0.3)
                hud.bezelView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                hud.mode = .indeterminate
                hud.tag = 10_000
                hud.contentColor = UIColor.init(hex: 0x00bdd2)
                hud.label.text = "请求中..."
                if let customText = text {
                    hud.label.text = customText
                }
                hud.label.font = UIFont.pingFangSCFont(size: 14)
                hud.label.textColor = UIColor.init(hex: 0x202A46)
                hud.minSize = CGSize.init(width: 108, height: 108)
                if let timeInterval = timeInterval {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: {
                        hud.hide(animated: true)
                    })
                }
            }
        }
    }
    /// hud 隐藏
    class func hideHud() {
        DispatchQueue.main.async {
            guard let hud = UIApplication.shared.keyWindow?.viewWithTag(10_000) as? MBProgressHUD else {
                return
            }
            hud.hide(animated: false)
        }
    }

}

extension AppUtil {
    /// 导航栏右侧按钮通用设置
    class func setupCommonNavTitleItem(_ item: UIBarButtonItem, font: UIFont = UIFont.pingFangSCFont(size: 15), normalColor: UIColor = AppColor.theme, disableColor: UIColor = UIColor.init(hex: 0x8C97AC)) -> Void {
        item.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: normalColor], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: normalColor], for: .highlighted)
        item.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: disableColor], for: .disabled)
    }

    /// 登出处理 isAuthValid 授权是否有效
    class func logoutProcess(isAuthValid: Bool = false, isSwitchLogin: Bool = true) -> Void {
        // 授权有效则发送退出请求
        if isAuthValid {
            AccountNetworkManager.logout { (_, _) in
            }
        }
        CacheManager.instance.clearWebCookieAndCache()
        AccountManager.share.logoutProcess()
        JPushHelper.instance.deleteAlias()
        if isSwitchLogin {
            RootManager.share.switchRoot(.login)
        }
    }

}

extension AppUtil {
    /// 获取系统配置
    class func getSystemConfig() -> Void {
//        SystemNetworkManager.appServerConfig { (status, msg, model) in
//            guard status, let model = model else {
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
//                    // 发送通知
//                    NotificationCenter.default.post(name: NSNotification.Name.App.getSystemConfig, object: nil)
//                })
//                return
//            }
//            AppConfig.share.server = model
//        }
    }

    /// 更新认证状态
    class func updateRealNameCert() -> Void {
//        CertificationNetworkManager.getRealNameCertDetail { (status, msg, model) in
//            // model.status有默认值，可能导致判断失效
//            guard status, let model = model, let _ = model.statusValue else {
//                return
//            }
//            if let userInfo = AccountManager.share.currentAccountInfo?.userInfo {
//                userInfo.certStatusValue = model.userCertStatus.rawValue
//                AccountManager.share.updateCurrentAccount(userInfo: userInfo)
//            }
//        }
    }

    /// 更新用户CT数(矿石)
    class func updateUserTotalCT() -> Void {
//        AssetNetworkManager.getAssetInfo { (status, msg, model) in
//            guard status, let model = model else {
//                return
//            }
//            AccountManager.share.currentAccountInfo?.userInfo?.totalCT = model.ore
//        }
    }

}

extension AppUtil {

    /// 通用的渐变色Layer，需添加frame，从左侧居中到右侧居中，
    class func commonGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [UIColor.init(hex: 0x169CFF).cgColor, AppColor.theme.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }

    /// 导出分享图片
    class func exportGradientImage(from layer: CAGradientLayer, size: CGSize) -> UIImage? {
        layer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }


    /// 通用的导航栏BarItem在normal状态下的TextAttributes
    class func commonNavBarItemNormalAtt() -> [NSAttributedString.Key: Any] {
        let normalAtt: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        return normalAtt
    }

   @objc class func topViewController() -> UIViewController? {
        guard let topVc = self.topViewControllerWithRootViewController(self.currentWindow().rootViewController) else {
            return nil
        }
        return topVc
    }

    class func currentWindow() -> UIWindow {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            for subWindow in UIApplication.shared.windows {
                if subWindow.windowLevel == UIWindow.Level.normal {
                    window = subWindow
                    break
                }
            }
        }
        return (window ?? nil)!
    }

    class func topViewControllerWithRootViewController(_ rootVC: UIViewController?) -> UIViewController? {
        guard let rootVC = rootVC else {
            return nil
        }
        if rootVC.presentedViewController != nil {
            return self.topViewControllerWithRootViewController(rootVC.presentedViewController!)
        } else if(rootVC.isKind(of: UITabBarController.self)) {
            let tabarbVC = rootVC as! UITabBarController
            return self.topViewControllerWithRootViewController(tabarbVC.selectedViewController!)

        } else if(rootVC.isKind(of: UINavigationController.self)) {
            let navVC = rootVC as! UINavigationController
            return self.topViewControllerWithRootViewController(navVC.visibleViewController!)

        } else if(rootVC.isKind(of: RootViewController.self)) {
            let navVC = rootVC as! RootViewController
            return self.topViewControllerWithRootViewController(navVC.children.first)

        } else {
            return rootVC
        }
    }

    /// 相差多少天
    class func differDay(date: Date) -> Int {
        let nowDate = Date()
        let nowTime = nowDate.timeIntervalSince1970
        let toTime = date.timeIntervalSince1970
        if toTime < nowTime {
            return 0
        }
        let dayDouble: Double = (toTime - nowTime) / (3600 * 24)
        let day = ceil(dayDouble)
        return Int(day)
    }

    /// 去前后空格和换行
    class func deleteWhiteCharacters(sourceString: String) -> String {
        return sourceString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
extension AppUtil {
    /// base加密
    class func base64Encoding(str: String) -> String {
        let strData = str.data(using: String.Encoding.utf8)
        let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        /// 加密失败返回自身
        guard let dataStr = base64String else {
            return str
        }
        return dataStr
    }
    /// 解码
    class func base64Decoding(encodedStr: String) -> String {
        let decodedData = NSData(base64Encoded: encodedStr, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        /// 解密失败返回自身
        guard let data = decodedData else {
            return encodedStr
        }
        /// 解密失败返回自身
        guard let decodedString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) else {
            return encodedStr
        }
        return decodedString as String
    }
}


extension AppUtil {

    /// webView的content展示处理: 特别是图片之类的等比问题解决
    class func contentShowWebStyle(strDetail: String) -> String {
        // 对内容布局处理
        var strStyle: String = ""
        if let url = Bundle.main.url(forAuxiliaryExecutable: "ProductDetail.css") {
            let string = try! String.init(contentsOf: url)
            strStyle = string
        }
        let strHtml = "<!DOCTYPE html>\n" +
            "<html>\n" +
            "<head>\n" +
            "   <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\" />" +
            "   <style>" + strStyle + "</style>\n" +
            "</head>\n" +
            "<body>\n" +
            "<div class = \"cap-richtext\">\n" +
            strDetail + "\n" +
            "</div>\n" +
            "</body>\n" +
        "</html>"
        return strHtml
    }

}

// MARK: - EnterPage
extension AppUtil {
    /// 显示网络设置弹窗
    class func showNetworkSettingAlert() -> Void {
        let alertVC = UIAlertController.init(title: "已为“\(AppConfig.share.appName)”关闭无线局域网", message: "你可以在“设置”中为此应用打开无线局域网", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "设置", style: .default, handler: { (action) in
            self.enterAppSettingPage()
        }))
        alertVC.addAction(UIAlertAction.init(title: "好", style: .default, handler: { (action) in
            self.enterAppSettingPage()
        }))
        DispatchQueue.main.async {
            RootManager.share.topRootVC.present(alertVC, animated: true, completion: nil)
        }
    }
    /// 进入应用设置页
    class func enterAppSettingPage() -> Void {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.openURL(url)
    }

}

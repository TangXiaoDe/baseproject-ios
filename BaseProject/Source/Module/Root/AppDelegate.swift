//
//  AppDelegate.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//

import UIKit
import RealmSwift
import MonkeyKing
import Bugly
import UserNotifications
import AMapFoundationKit
import Kingfisher
import ObjectMapper

// 依赖库，一次引入不用多次引入
import SnapKit
import ChainOneKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.appSetup(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
        AppReachability.share.stopListener()

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
        NotificationCenter.default.post(name: Notification.Name.App.enterBackground, object: nil, userInfo: nil)
        AppReachability.share.stopListener()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        NotificationCenter.default.post(name: Notification.Name.App.enterForeground, object: nil, userInfo: nil)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        //销毁通知红点
//        UIApplication.shared.applicationIconBadgeNumber = 0
//        JPUSHService.setBadge(0)
//        UIApplication.shared.cancelAllLocalNotifications()

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        AppReachability.share.startListener()

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        //return true

        // 该版本暂屏蔽支付宝支付
//        // 支付宝判断
//        if let host = url.host, host == "safepay" {
//            //跳转支付宝钱包进行支付，处理支付结果
//            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
//                if let resultDic = resultDic as? [String: Any] {
//                    PayUtil.alipayResultProcess(resultDic)
//                }
//            })
//            return true
//        }
        // 注意Monking的handleOpenURL与wechatHandleOpen的先后顺序，否则可能导致MonkeyKing分享异常
        if MonkeyKing.handleOpenURL(url) {
            return true
        }
        if self.wechatHandleOpen(url: url) {
            return true
        }
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //return true

        // 该版本暂屏蔽支付宝支付
//        // 支付宝判断
//        if let host = url.host, host == "safepay" {
//            //跳转支付宝钱包进行支付，处理支付结果
//            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
//                if let resultDic = resultDic as? [String: Any] {
//                    PayUtil.alipayResultProcess(resultDic)
//                }
//            })
//            return true
//        }
        if MonkeyKing.handleOpenURL(url) {
            if url.absoluteString.hasPrefix("wx") && url.absoluteString.contains("://pay/") {
                return self.wechatHandleOpen(url: url)
            }
            return true
        }
        if self.wechatHandleOpen(url: url) {
            return true
        }
        return true
    }

}

extension AppDelegate {

}

// MARK: - setup
extension AppDelegate {
    /// app设置
    fileprivate func appSetup(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Void {
        self.justTest()
        // 数据库配置
        self.setupDataBase()
        // 网络请求
        self.setupNetwork()
        /// 分享配置(使用MonkeyKing)
        self.setupShareConfig()
        // 图片缓存设置
        self.setupImageCache()
        // 广告
        self.setupAdvert()
        /// 应用启动配置(来自服务器)
        self.setupAppLaunchConfig()
        /// UM配置
        self.setupUMeng()
        /// 崩溃收集
        self.setupCrash()
        /// 极光推送配置
        self.setupJPush(didFinishLaunchingWithOptions: launchOptions)
        // 应用UI配置
        self.setupAppUI()
        // 根控
        self.setupRootVC()
        // 远程通知启动
        self.remoteNotificationLaunchProcess(launchOptions)
        /// 地图配置
        self.setupMap()
    }

    /// 根控加载
    fileprivate func setupRootVC() -> Void {
        let rootVC = RootManager.share.rootVC
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        self.window = window
    }

    /// 应用UI配置
    fileprivate func setupAppUI() -> Void {
        // navigationBar配置 - 同步(必须同步而不是异步，否则默认展示的导航控制器会显示异常)
        let titleFont: UIFont = UIFont.pingFangSCFont(size: 18, weight: .medium)
        UINavigationController.setNavBarTheme(titleFont: titleFont, titleColor: UIColor.white, tintColor: UIColor.white, barTintColor: UIColor.init(hex: 0x2D385C), isTranslucent: false, bgImage: UIImage(), shadowColor: UIColor.init(hex: 0x202A46))

        /// 该类初始化之后，配置整个应用: 主题色等 - 异步
        DispatchQueue.main.async {
            // input
            //UITextField.appearance().tintColor = TSColor.main.theme
            //UITextView.appearance().tintColor = TSColor.main.theme
            // button
            UIButton.appearance().isExclusiveTouch = true
            UIControl.appearance().isExclusiveTouch = true
            // UITabBarItem
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 10, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x8C97AC)], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 10, weight: .medium), NSAttributedString.Key.foregroundColor: AppColor.theme], for: .selected)
        }
        UIApplication.shared.statusBarStyle = .lightContent
        // 解决Tabbar中pusha再pop时有自定义导航栏的界面tabbar跳动的问题
        UITabBar.appearance().isTranslucent = false
    }

    /// 网络配置
    fileprivate func setupNetwork() -> Void {
        let manager = NetworkManager.share
        manager.configRootURL(rootURL: AppConfig.share.serverAddr.address)
    }

    /// 数据库配置
    fileprivate func setupDataBase() {
        let currentSchema: UInt64 = AppConfig.share.schemaVersion
        let config = Realm.Configuration(
            schemaVersion: currentSchema, // 当前数据库版本号
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < currentSchema {
                    // 没有什么要做的！
                    // Realm 会自行检测新增和被移除的属性
                    // 然后会自动更新磁盘上的架构
                }
        })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm() // 关闭iOS文件目录锁定保护
        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.none], ofItemAtPath: folderPath)
    }

    /// 图片下载与缓存库kingsher配置
    fileprivate func setupImageCache() -> Void {
        // 当收到内存警告时，Kingfisher将清除内存缓存，并在需要时清除已过期和大小超时的缓存。通常没有必要清理缓存。
        // Kingfisher 默认支持自动处理PNG, JPEG 和 GIF 图片格式
        ImageCache.default.maxCachePeriodInSecond = TimeInterval(60 * 60 * 24 * 7) // 7天的秒数
        ImageCache.default.maxDiskCacheSize = 209_715_200 // 200M 最大图片缓存
        ImageDownloader.default.downloadTimeout = 20.0 // 20秒
    }

    /// 广告配置
    fileprivate func setupAdvert() -> Void {
        AdvertManager.share.downloadAllAds()
    }

    fileprivate func setupShareConfig() {
        // 向微信注册(暂时用分享的appId)
        // 微信支付/提现只能使用正式服的，否则异常，导致测试服分享异常
        let appId = ThirdConfig.release.wechat.appId    // AppConfig.share.third.wechat.appId
        let universalLink = AppConfig.share.third.wechat.universalLink
        WXApi.registerApp(appId, universalLink: universalLink)
        MonkeyKing.registerAccount(ShareManager.thirdAccout(type: .wechat))

        //MonkeyKing.registerAccount(ShareManager.thirdAccout(type: .qq))
        //MonkeyKing.registerAccount(ShareManager.thirdAccout(type: .weibo))
    }

    /// 应用启动配置
    fileprivate func setupAppLaunchConfig() -> Void {
        AppUtil.getSystemConfig()
    }

    /// UMeng配置
    fileprivate func setupUMeng() -> Void {
        let appKey: String = AppConfig.share.third.umeng.appKey
        let channel: String = "signature" // signature/appstore
        //初始化友盟所有组件产品
        UMConfigure.initWithAppkey(appKey, channel: channel)
        //友盟默认是获取的build，内部构建的版本号，如果需要在统计中显示的版本号与AppStore一直的话，则需要加入以下代码。
        if let bundleDic = Bundle.main.infoDictionary, let version = bundleDic["CFBundleShortVersionString"] as? String, let versionNum = Int(version) {
            MobClick.setVersion(versionNum)
        }
        // 类型
        MobClick.setScenarioType(.E_UM_NORMAL)
        MobClick.setSecret(appKey)
        //// 开启Crash收集
        //MobClick.setCrashReportEnabled(true)
    }

    /// 崩溃收集
    fileprivate func setupCrash() -> Void {
        // debug版运行和打包 都不配置bugly，仅release版配置bugly，这么做便于bug解析(符号表配置 需上传对应包的dSYM文件)。
        // 无论正式与测试，
        //      每次打包对应版本的Build数加1，分支上的tag修正，甚至可保存对应包的dSYM文件(暂不保存)。
        //      每次打包都打release版的，即Ad-Hoc模式或AppStore模式，禁止打Development模式的包；
        // 因为：若正常开发时的崩溃问题上传bugly，根本就没有对应版本的包文件，无法解析bug。
        #if DEBUG
        #else
        let buglyId = AppConfig.share.third.bugly.appId
        Bugly.start(withAppId: buglyId)
        #endif
    }

    /// 地图配置
    fileprivate func setupMap() -> Void {
        //高德
        AMapServices.shared().apiKey = AppConfig.share.third.amap.appKey
    }

    /// 远程通知启动处理
    fileprivate func remoteNotificationLaunchProcess(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Void {
        guard let _ = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] else {
            return
        }
        //如果有值，说明是通过远程推送来启动的
        AppConfig.share.internal.launch = .remote
    }

}

// MARK: - justTest
extension AppDelegate {
    fileprivate func justTest() -> Void {
        var strTest: String = "哈哈哈哈"
        print(strTest + ": " + strTest.pinYinFirstLetter())
        strTest = "长江"
        print(strTest + ": " + strTest.pinYinFirstLetter())
        strTest = "重要"
        print(strTest + ": " + strTest.pinYinFirstLetter())
        strTest = "😁"
        print(strTest + ": " + strTest.pinYinFirstLetter())
        strTest = ""
        print(strTest + ": " + strTest.pinYinFirstLetter())

    }

}

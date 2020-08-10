//
//  JPushManager.swift
//  BaseProject
//
//  Created by 斯敬之 on 2019/3/1.
//  Copyright © 2019年 ChainOne. All rights reserved.
//
//  极光推送相关

import Foundation
import UserNotifications

extension AppDelegate {
    /// 极光推送配置
    func setupJPush(didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //let types: UInt = UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue
        let types: UInt = UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue
        if #available(iOS 10.0, *) {
            let entity = JPUSHRegisterEntity()
            entity.types = Int(types)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        } else {
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }

        #if DEBUG
        let isProduction = false
        #else
        let isProduction = true
        #endif
        let jPushKey = AppConfig.share.third.jpush.appKey
        JPUSHService.setup(withOption: launchOptions, appKey: jPushKey, channel: nil, apsForProduction: isProduction)
    }

    /// 处理推送数据
    func processReceivePush(_ userInfo: [String: Any]) {
        print("processReceivePush")
        print(userInfo)
        NotificationCenter.default.post(name: Notification.Name.Message.refresh, object: nil, userInfo: nil)
    }
}

extension AppDelegate {
    /// 注册 APNs 成功并上报 DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    /// 注册 APNs 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}

extension AppDelegate: JPUSHRegisterDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        print("jpushNotificationCenter openSettingsFor \(notification?.description)")
    }

    /// 前台收到消息
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {

        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        if let userInfo = userInfo as? [String: Any] {
            processReceivePush(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        let bage = Int(UNNotificationPresentationOptions.alert.rawValue | UNNotificationPresentationOptions.badge.rawValue)
        completionHandler(bage)

    }

    /// 后台点击了通知栏,会调用该方法
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {

        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        if let userInfo = userInfo as? [String: Any] {
            processReceivePush(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()

    }

}

extension AppDelegate {
    /// iOS 7 上会调用该处相关代码
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        if let userInfo = userInfo as? [String: Any] {
            processReceivePush(userInfo)
        }
        completionHandler(UIBackgroundFetchResult.newData)
        NotificationCenter.default.post(name: Notification.Name.APNS.click, object: nil, userInfo: nil)
    }

    //点推送进来执行这个方法
    /// `App`状态为未运行时,用户点击`apn`通知导致`app`被启动运行
    /// 如果未调用该方法则表示`App`不是因点击`apn`而被启动,可能为直接点击icon被启动或其他.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable:Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        NotificationCenter.default.post(name: Notification.Name.APNS.click, object: nil, userInfo: nil)
    }

}

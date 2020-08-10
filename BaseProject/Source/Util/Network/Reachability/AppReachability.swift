//
//  BaseProjectReachability.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/11.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  BaseProject的网络监测，对ReachabilitySwift的封装

import Foundation
import Reachability

extension Notification.Name {
    struct app {
        /// 网络状态变更
        static let reachabilityChanged = Notification.Name.init("app.notification.name.imeet.reachabilityChanged")
    }
}

class AppReachability {
    /// 当前网络连接状态
    enum Connection {
        /// wifi链接
        case wifi
        /// 移动网络
        case cellular
        /// 无连接
        case none

        static func connWithReachability(_ reachability: Reachability?) -> AppReachability.Connection {
            var conn: AppReachability.Connection = AppReachability.Connection.none
            guard let reachability = reachability else {
                return none
            }
            conn = AppReachability.Connection.connWithReachabilityConnection(reachability.connection)
            return conn
        }
        static func connWithReachabilityConnection(_ connection: Reachability.Connection) -> AppReachability.Connection {
            var conn: AppReachability.Connection = AppReachability.Connection.none
            switch connection {
            case .wifi:
                conn = .wifi
            case .cellular:
                conn = .cellular
            case .none:
                conn = .none
            }
            return conn
        }

    }

    /// 当前网络连接状态
    var currentConn: AppReachability.Connection {
        let conn: AppReachability.Connection = AppReachability.Connection.connWithReachability(self.reachability)
        return conn
    }


    fileprivate let reachability: Reachability?

    /// 单例
    static let share = AppReachability()
    private init() {
        self.reachability = Reachability()
        //self.reachability = Reachability.init(hostname: "http://www.baidu.com")!
    }

    deinit {
        self.stopListener()
    }

    func startListener() -> Void {
        guard let reachability = self.reachability else {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChangedNotifyProcess(_:)), name: .reachabilityChanged, object: nil)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    func stopListener() -> Void {
        self.reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }

    /// 通知处理
    @objc fileprivate func reachabilityChangedNotifyProcess(_ notification: Notification) -> Void {
        guard let reachability = self.reachability else {
            return
        }
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
        NotificationCenter.default.post(name: NSNotification.Name.app.reachabilityChanged, object: self.currentConn, userInfo: nil)
    }

}

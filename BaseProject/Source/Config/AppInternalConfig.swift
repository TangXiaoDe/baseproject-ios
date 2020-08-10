//
//  AppInternalConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  App内部配置

import Foundation

class InternalConfig {

    static let `default`: InternalConfig = InternalConfig()

    var pageLimit: Int = 15
    var allowRotation: Bool = false
    var allowVisitor: Bool = false
    /// 积分名称
    var jifenName: String = ""

    /// 是否已设置推送别名 - 登录设置、退出移除、但注册时获取用户失败也进入主页但没有设置别名
    var settedJPushAlias: Bool = true

    /// 启动类型，默认为点击APPIcon启动
    var launch: LaunchType = .appIcon

    var isFirstEnter: Bool {
        // 获取当前版本号
        let currentVersion = VersionManager.share.currentVersion
        // 获取保存的版本号
        let lastVersion = VersionManager.share.savedVersion
        let newFlag: Bool = (currentVersion != lastVersion)
        return newFlag
    }

    init() {

    }

}

/// 启动类型
enum LaunchType {
    /// 点击App图标
    case appIcon
    /// 点击通知 - 已登录则进入tabbar后默认进入消息页，若未登录则不予处理
    case remote
    /// 别的应用打开 - 暂不作处理
    case openurl
}

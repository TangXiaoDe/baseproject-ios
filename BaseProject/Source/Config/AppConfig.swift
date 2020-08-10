//
//  AppConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  App配置
//  TODO: - App配置应考虑使用plist文件方式进行加载。

import Foundation
import ObjectMapper

/// 配置类型
enum ConfigType {
    /// 测试服
    case develop
    /// 正式服
    case release
}

/// App配置
class AppConfig {

    static let share = AppConfig(type: .develop)
    init(type: ConfigType) {
        self.type = type
        switch type {
        case .develop:
            self.serverAddr = ServerAddressConfig.develop
            self.third = ThirdConfig.develop
            self.shield = ShieldConfig.develop
            self.appId = "1476380580"
            self.appScheme = "iMeet"
            self.aiderId = 35
        case .release:
            self.serverAddr = ServerAddressConfig.release
            self.third = ThirdConfig.release
            self.shield = ShieldConfig.release
            self.appId = "1476380580"
            self.appScheme = "iMeet"
            self.aiderId = 32
        }
        // appName
        if let displayName = self.bundle.displayName, !displayName.isEmpty {
            self.appName = displayName
        } else if "CFBundleDisplayName".localized != "CFBundleDisplayName" {
            self.appName = "CFBundleDisplayName".localized
        } else {
            self.appName = self.bundle.name
        }
    }

    /// 配置类型
    let type: ConfigType
    /// 服务器地址配置
    let serverAddr: ServerAddressConfig
    /// 三方配置
    let third: ThirdConfig
    /// 屏蔽设置
    let shield: ShieldConfig
    /// Bundle相关—— BundleId/Version/Build/AppName
    let bundle: BundleInfoModel = Mapper<BundleInfoModel>().map(JSONObject: Bundle.main.infoDictionary) ?? BundleInfoModel()

    /// 数据库版本，每次数据库版本更新都应加1；
    let schemaVersion: UInt64 = 6

    /// appId
    let appId: String
    /// app名称
    let appName: String
    /// appScheme
    let appScheme: String
    /// 链乎小助手id
    let aiderId: Int

    /// app内部配置
    let `internal`: InternalConfig = InternalConfig.default
    /// app主题配置 - 可切换
    var theme: ThemeConfig = ThemeConfig.default

    /// 服务器配置(来自服务器的配置，本地有默认配置，每次启动app时会请求并更新本地配置)
    var server: ServerConfigModel?

    /// 显示测试界面
    var showTest: Bool = false

}

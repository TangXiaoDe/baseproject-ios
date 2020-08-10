//
//  ShieldConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  屏蔽设置

import Foundation
import CryptoSwift

struct ShieldConfig {
    /// 屏蔽账号列表
    var shieldAccounts: [String] = []
    /// 当前账号是否屏蔽，游客也作为屏蔽账号处理
    var currentNeedShield: Bool {
        var needShieldFlag: Bool = true
        guard let currentAccount = AccountManager.share.currentAccountInfo?.account else {
            return needShieldFlag
        }
        needShieldFlag = self.shieldAccounts.contains(currentAccount.md5())
        return needShieldFlag
    }

    init(shieldAccounts: [String]) {
        self.shieldAccounts = shieldAccounts
    }

    static let develop: ShieldConfig = ShieldConfig(shieldAccounts: ShieldConfig.developShieldAccounts)
    static let release: ShieldConfig = ShieldConfig(shieldAccounts: ShieldConfig.releaseShieldAccounts)
    /// 屏蔽账号 - md5转换 17323180923/13800138000
    static let developShieldAccounts: [String] = ["a43e1a22bcdb93adf027bd728d32b2ed", "7945bd83237335e5376ff44d62e4f0ae"]
    static let releaseShieldAccounts: [String] = ["7945bd83237335e5376ff44d62e4f0ae"]

}

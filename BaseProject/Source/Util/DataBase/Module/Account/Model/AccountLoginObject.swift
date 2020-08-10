//
//  AccountLoginObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号登录数据库模型

import Foundation
import RealmSwift

/// 账号登录相关信息
class AccountLoginObject: Object {
    /// 账号信息
    @objc dynamic var account: String = ""
    /// 是否上次登录，所有账号中只能有一个是
    @objc dynamic var isLast: Bool = false
    /// 是否登录，标记该账号是否登录，退出登录、无效登录、token过期、401token无效等都会作为未登录处理
    @objc dynamic var isLogin: Bool = false

    /// 设置主键
    override static func primaryKey() -> String? {
        return "account"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["account"]
    }

}

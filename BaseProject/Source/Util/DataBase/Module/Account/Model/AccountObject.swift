//
//  AccountObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号的数据库模型

import Foundation
import RealmSwift

/// 账号数据库模型
class AccountObject: Object {

    /// 用户账号
    @objc dynamic var account: String = ""
    /// token
    @objc dynamic var token: AccountTokenObject? = nil
    /// 用户信息
    @objc dynamic var userInfo: CurrentUserObject? = nil
    /// 用户登录信息
    @objc dynamic var loginInfo: AccountLoginObject? = nil

    /// 设置主键
    override static func primaryKey() -> String? {
        return "account"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["account"]
    }
}

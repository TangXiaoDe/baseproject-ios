//
//  AccountTokenObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号Token的数据库模型

import Foundation
import RealmSwift

/// Token的数据库模型
class AccountTokenObject: Object {

    /// 用户账号
    @objc dynamic var account: String = ""
    /// token
    @objc dynamic var token: String = ""

    /// 设置主键
    override static func primaryKey() -> String? {
        return nil
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return []
    }
}

//
//  UserUpChainObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/12/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  用户上链数据库模型

import Foundation
import RealmSwift

class UserUpChainObject: Object {

    /// 用户id
    @objc dynamic var userId: Int = 0
    /// 私钥
    @objc dynamic var privateKey: String = ""
    /// 地址
    @objc dynamic var address: String = ""
    /// 契约地址
    @objc dynamic var contractAddress: String = ""

    /// 设置主键
    override static func primaryKey() -> String? {
        return "userId"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["userId"]
    }

}

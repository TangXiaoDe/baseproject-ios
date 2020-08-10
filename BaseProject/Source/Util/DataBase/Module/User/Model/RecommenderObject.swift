//
//  RecommenderObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  推荐人数据库模型

import Foundation
import RealmSwift

/// 推荐人的数据库模型
class RecommenderObject: Object {

    /// 用户id
    @objc dynamic var id: Int = 0
    /// 用户名称
    @objc dynamic var name: String = ""
    /// 用户头像
    @objc dynamic var avatar: String = ""
    /// 邀请时间
    @objc dynamic var invitedDate: Date = Date()

    /// 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

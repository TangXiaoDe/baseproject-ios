//
//  AdvertSpaceObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告位的数据库模型

import Foundation
import RealmSwift

/// 广告位的数据库模型
class AdvertSpaceObject: Object {

    /// 广告位id
    @objc dynamic var id: Int = 0
    /// 广告位标示
    @objc dynamic var space: String = ""
    /// 广告位描述
    @objc dynamic var alias: String = ""

    /// 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

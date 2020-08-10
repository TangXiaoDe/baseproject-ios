//
//  UserTagObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  用户标签的数据库模型

import Foundation
import RealmSwift

class UserTagObject: Object {

    /// id
    @objc dynamic var id: Int = 0
    /// 昵称
    @objc dynamic var title: String = ""
    /// 标签分组id
    @objc dynamic var cateId: Int = 0


    /// 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

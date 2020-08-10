//
//  LevelObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  等级数据库模型

import Foundation
import RealmSwift


typealias UserGradeObject = LevelObject
typealias UserLevelObject = LevelObject
typealias GradeObject = LevelObject
class LevelObject: Object {

    /// 等级
    @objc dynamic var level: String = ""
    /// 等级名称
    @objc dynamic var name: String = ""
    /// 当前等级大图标
    @objc dynamic var iconFileName: String = ""
    /// 当前等级小图标
    @objc dynamic var smallIconFileName: String = ""
    /// 当前等级最小经验值 - 矿力值
    @objc dynamic var minExperience: Int = 0
    /// 当前等级最大值 - 矿力值
    @objc dynamic var maxExperience: Int = 0
    /// 下个等级名称
    @objc dynamic var nextLevelName: String = ""

    /// 设置主键
    override static func primaryKey() -> String? {
        return "level"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["level"]
    }

}

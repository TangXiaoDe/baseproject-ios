//
//  UserExtraObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  用户附加信息数据库模型

import Foundation
import RealmSwift

class UserExtraObject: Object {

    /// id
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    /// 组统计
    @objc dynamic var groupCount: Int = 0
    /// 收藏统计
    @objc dynamic var collectCount: Int = 0
    /// 评论统计
    @objc dynamic var commentCount: Int = 0
    /// 点赞统计
    @objc dynamic var likeCount: Int = 0
    /// 动态统计
    @objc dynamic var dynamicCount: Int = 0
    /// 一级邀请用户数量
    @objc dynamic var levelOneInviteCount: Int = 0
    /// 二级邀请用户数量
    @objc dynamic var levelTwoInviteCount: Int = 0
    /// 被点赞数量
    @objc dynamic var obtainLikeCount: Int = 0
    /// 扩展字段
    @objc dynamic var extend: String? = nil


    /// 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

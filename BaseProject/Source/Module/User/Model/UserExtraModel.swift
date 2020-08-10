//
//  UserExtraModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  用户附加信息数据模型

import Foundation
import ObjectMapper

/// 用户附加信息数据模型
class UserExtraModel: Mappable {

    var id: Int = 0
    var userId: Int = 0
    /// 组统计
    var groupCount: Int = 0
    /// 收藏统计
    var collectCount: Int = 0
    /// 评论统计
    var commentCount: Int = 0
    /// 点赞统计
    var likeCount: Int = 0
    /// 动态统计
    var dynamicCount: Int = 0
    /// 一级邀请用户数量
    var levelOneInviteCount: Int = 0
    /// 二级邀请用户数量
    var levelTwoInviteCount: Int = 0
    /// 被点赞数量
    var obtainLikeCount: Int = 0
    /// 扩展字段
    var extend: String? = nil

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["user_id"]
        groupCount <- map["group_count"]
        collectCount <- map["collect_count"]
        commentCount <- map["comment_count"]
        likeCount <- map["like_count"]
        dynamicCount <- map["dynamic_count"]
        levelOneInviteCount <- map["one_level_invite_count"]
        levelTwoInviteCount <- map["two_level_invite_count"]
        obtainLikeCount <- map["obtain_like_count"]
        extend <- map["extend"]
    }

    // MARK: - Realm
    init(object: UserExtraObject) {
        self.id = object.id
        self.userId = object.userId
        self.groupCount = object.groupCount
        self.collectCount = object.collectCount
        self.commentCount = object.commentCount
        self.likeCount = object.likeCount
        self.dynamicCount = object.dynamicCount
        self.levelOneInviteCount = object.levelOneInviteCount
        self.levelTwoInviteCount = object.levelTwoInviteCount
        self.obtainLikeCount = object.obtainLikeCount
        self.extend = object.extend
    }
    func object() -> UserExtraObject {
        let object = UserExtraObject()
        object.id = self.id
        object.userId = self.userId
        object.groupCount = self.groupCount
        object.collectCount = self.collectCount
        object.commentCount = self.commentCount
        object.likeCount = self.likeCount
        object.dynamicCount = self.dynamicCount
        object.levelOneInviteCount = self.levelOneInviteCount
        object.levelTwoInviteCount = self.levelTwoInviteCount
        object.obtainLikeCount = self.obtainLikeCount
        object.extend = self.extend
        return object
    }

}

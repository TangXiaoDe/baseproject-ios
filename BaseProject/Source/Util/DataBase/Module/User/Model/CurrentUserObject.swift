//
//  CurrentUserObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  当前用户的数据库模型

import Foundation
import RealmSwift

/// 当前用户的数据库模型
class CurrentUserObject: Object {

    /// id
    @objc dynamic var id: Int = 0
    /// 昵称
    @objc dynamic var name: String = ""
    /// 性别 0-未知[保密] 1-男 2-女
    @objc dynamic var sexValue: Int = 0
    /// 电话号码，[注]返回的电话号码中间4位数字处理过
    @objc dynamic var phone: String = ""
    /// IMeet账号
    @objc dynamic var number: String = ""
    /// 头像链接
    @objc dynamic var avatar: String? = nil
    /// 是否大咖
    @objc dynamic var big_name: Int = 0
    /// 背景链接
    @objc dynamic var background: String? = nil
    /// 生日
    @objc dynamic var birthday: String? = nil
    /// 环信登录密码
    @objc dynamic var easemobPwd: String = ""
    /// 邀请码
    @objc dynamic var inviteCode: String = ""
    /// 简介
    @objc dynamic var bio: String = ""
    /// 矿力
    @objc dynamic var power: Int = 0
    /// 是否设置过支付密码
    @objc dynamic var payPwdStatus: Bool = false
    /// 附加模型
    @objc dynamic var extra: UserExtraObject? = nil
    /// 用户标签
    let tags = List<UserTagObject>()
    /// 推荐人
    @objc dynamic var recommender: RecommenderObject? = nil
    /// 用户等级
    @objc dynamic var grade: UserGradeObject? = nil
    /// 认证状态
    @objc dynamic var certStatusValue: String = ""
    /// 上链信息
    @objc dynamic var chain: UserUpChainObject? = nil


    /// 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

//
//  ServerConfigModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/25.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  服务器配置数据模型

import Foundation
import ObjectMapper

/// 服务器配置数据模型
class ServerConfigModel: Mappable {

    /// cdn域名
    var cdnDomain: String = ""
    /// 商务联系数据模型
    var business: BusinessContactModel?
    /// 退出天数(社群加入社区)
    var quitDay: Int = 0
    /// 红包限制
    var bonusLimit: BonusLimitModel?
//    /// 注册协议
//    var registerAgreement: String = ""
//    /// 是否开启版本管理
//    var isVersionControl: Bool = false

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        cdnDomain <- map["cdn_domain"]
        business <- map["business"]
        quitDay <- map["quit_limit_day"]
        bonusLimit <- map["bonus"]
//        registerAgreement <- map["register_protocol"]
//        isVersionControl <- map["start_version_control"]
    }

}

/// 商务联系方式数据模型
class BusinessContactModel: Mappable {

    var qq: String = ""
    var email: String = ""
    var imeet: String = ""
    var wechat: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        //qq <- map["qq"]
        //email <- map["email"]
        //imeet <- map["imeet"]
        //wechat <- map["wechat"]
        qq <- map["Q Q"]
        email <- map["邮箱"]
        imeet <- map["链乎"]
        wechat <- map["微信"]
    }

}

/// 红包限制相关
class BonusLimitModel: Mappable {

    /// 红包最小金额
    var amountMin: Double = 0.01
    /// 个人红包最大金额
    var personalAmountMax: Double = 200
    /// 社群红包总金额 自己算
    var groupAmountMax: Double = 20_000
    /// 社群每个红包最大领取用户数
    var groupReceiveUserMax: Int = 100
    /// 单个用户每天能发的红包金额上限？ - 不予处理
    var userDaily: Double = 1_000


    required init?(map: Map) {

    }
    func mapping(map: Map) {
        amountMin <- (map["min_limit"], DoubleStringTransform.default)
        personalAmountMax <- (map["max_limit"], DoubleStringTransform.default)
        //groupAmountMax <- map["group_max_limit"]
        groupReceiveUserMax <- (map["group_num_limit"], IntegerStringTransform.default)
        userDaily <- (map["user_daily_limit"], DoubleStringTransform.default)
    }

}

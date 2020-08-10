//
//  CashPayInfoModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  现金支付信息数据模型

import Foundation

/// 现金支付源类型 -> 支付目的类型
enum CashPaySourceType {
    case groupUpgrade
    case miningRecharge
}

enum CashPayType {
    case alipay
    case wechat

    /// 支付方式，用于一键挖矿现金支付时的参数
    var pay_type: String {
        var type: String
        switch self {
        case .alipay:
            type = "alipay"
        case .wechat:
            type = "wxpay"
        }
        return type
    }

}

/// 现金支付信息数据模型
class CashPayInfoModel {

    /// 支付类型
    var payType: CashPayType
    /// 订单编号
    var orderno: String
    /// 支付源类型(目的类型)
    var sourceType: CashPaySourceType

    /// 社群id，仅社群升级时可用
    var groupId: Int? = nil

    init(payType: CashPayType, orderno: String) {
        self.payType = payType
        self.orderno = orderno
        self.sourceType = .miningRecharge   // 默认为挖矿充值
    }

    init(groupId: Int, payType: CashPayType, orderno: String) {
        self.payType = payType
        self.orderno = orderno
        self.groupId = groupId
        self.sourceType = .groupUpgrade
    }

}
